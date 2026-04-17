Received: from mail.mokrynskyi.com (mail.mokrynskyi.com [65.109.39.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FE9312837;
	Fri, 17 Apr 2026 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.39.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776461489; cv=none; b=q6Cnhv0PPaBxYb1K+yUj4OV/BE1FRQyhbjCQt/4bu+qdBt8NRh5jvBQAOnRA1dLN93JRpZ/J1oVfGPtDpI/G68irt4ZslyFML5iQ3lzE3A8BJlJAAunl0KXDjxXeO4GXrbW0SdA52v4jMjj4KODHKMEsQUUQABGG4QHr1MvaWks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776461489; c=relaxed/simple;
	bh=hDnr7rvCAuC1Mz/Vw8NiUhd9OeIeQQxH/axtcsNGras=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=k5mpnGqeZaM1n7bbA/OICSnooX1e3Q2guU7eBzihiZ4s/MFzHJYl4tuId61S7G3F8do6Wg/HRpYl0EIq+SGXvBpMJSAh0nQn1djB2hP2Pp8SeedRNhg9dqhuQ2PMq5WpZ4U9OysbY1pIYPgQK5jWvQEqbzZoR41TnpAPTGlZ6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com; spf=pass smtp.mailfrom=mokrynskyi.com; dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b=JjlGFDNz; arc=none smtp.client-ip=65.109.39.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b="JjlGFDNz"
Message-ID: <70de9b8f-b7c7-481b-8cb1-931e3b82eb0e@mokrynskyi.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mokrynskyi.com;
	s=dkim; t=1776461049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TfRH7RLbIkFLwYqxcqnC/b9w+6mZVTcenEo66bU9AeA=;
	b=JjlGFDNzgqiPA2kl7IWog9KrUG4J9CeDZztNVtiAnDUXXSjxZeK27GW3PR9DxqzQha3U0Q
	Tu7OKV+T2mzxdO10O7YFhBfhxK7teROkp25Ctb8+3r6RpRRpqUPcEKiwTEeai7JQ1+Kl1h
	tjdI1sLb5aL0dr19DaSljRqgUxdsCxnmR42RxU29DWkTDuXWtfJ5pNIrJ4KshdojfOVqBH
	VIHrKsruqxnWmIvL8QWrC76pb+AWb89uYO5+1T/fHxh07iI9VPfeHJStfu2gEy9ArmMnPa
	zQFRDTPluZX46pfB5zvJ20+ahmm1ocMC1yFjdLOdeWeDFZMga8/qOUzhQclsCQ==
Authentication-Results: mail.mokrynskyi.com;
	auth=pass smtp.mailfrom=nazar@mokrynskyi.com
Date: Sat, 18 Apr 2026 00:24:07 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US, uk, uk-UA
From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
Subject: vfio/pci: Qualcomm PCIe WiFi devices drop link during FLR causing
 host AER crash
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, jgg@ziepe.ca, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ---

Several Qualcomm PCIe WiFi devices drop their PCIe link as part of their
internal reset sequence. Under bare metal this is transparent because the
host root complex performs link retraining automatically. Under VFIO
passthrough, the link-drop generates an uncorrectable AER error that
escalates through the parent bridge to the host, crashing it.

Affected devices confirmed so far:
  17cb:1107  WCN7850  (ath12k driver)
  17cb:1109  QCN9274  (ath12k driver)

Other Qualcomm PCIe WiFi devices from the same family should all
exhibit the same behavior and I believe ath11k devices as well since
they share a lot of the code.

The host crashes both when the VM is gracefully shut down or rebooted
(the guest driver performs a reset as part of its shutdown sequence) and
when the VM is forcefully destroyed. In both cases the crash is caused by
a PCIe link-drop from the device that the host AER handler treats as
fatal.

The only available workaround is pci=noaer on the host kernel command
line, which disables AER globally and breaks ACS-based IOMMU group
isolation required for passing other devices to other VMs.

The driver-side initialization issue - the device also drops its link
when the guest driver probes it on boot - has been worked around in
OpenWrt by skipping the global reset on initial power-up. See:
https://github.com/openwrt/openwrt/pull/22969

However, graceful shutdown and force-destroy both remain broken and
continue to crash the host, as the device performs a reset during driver
shutdown and the host crashes regardless of how the VM exits.

The fix should be in vfio-pci: when taking ownership of a device, suppress
AER error reporting on that device for the duration of guest ownership.
This prevents guest-triggered hardware behaviors, including link-drops
caused by device resets initiated by the guest driver, from crashing the
host.

Whether this should be applied generally to all vfio-pci devices or
only to specific device IDs via a quirk is left to maintainer discretion.
A general approach is defensible: suppressing error reporting on a device
handed to an untrusted guest is correct behavior regardless of whether the
device drops its link, as the host cannot meaningfully act on errors
generated by guest-controlled hardware activity.
If this is not done by default, a kernel option under `vfio-pci` like
`ids` would be nice for those who need to check whether the quirk is
needed before reporting it upstream.

This has been happening for as long as I owned ath11k (QCN9074) and
ath12k (QCN9274) devices under different kernel/QEMU versions and others
reported the same in various places:
https://forum.openwrt.org/t/qcn9274-crashes-the-system-during-driver-load/239491?u=nazar-pc
https://github.com/openwrt/openwrt/issues/17193

Hardware context: these devices are Qualcomm 802.11be (WiFi 7) PCIe
modules commonly used in router/AP hardware and passed through to
OpenWRT to create a virtualized access point.

-- 
Sincerely, Nazar Mokrynskyi
github.com/nazar-pc

