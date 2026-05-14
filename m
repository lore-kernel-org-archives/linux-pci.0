Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE538A714
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761407; cv=none; b=S8tlbn7/YEs2uwqZ1egIrAkMghSTw0I40IRXhXwf4u8//6ZVjn0e3Ngw9+qRPpWpOlrJbgbKACVWUdiqUd1SsDvZIfJvfpA5lGp+raxkP2iWtYnn51mg3H/cFOWR540Xl/IK+FdnfoXAQdVrJXnpEyarDeCN/Jsg+1nJ3tgiac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761407; c=relaxed/simple;
	bh=JBrD+ei0vHVv5yHpBCWJksPsH2/f4z997cFGzTjggdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORKpJCCWP3/mXKAfL2Nll7/QYIMToNKGLGv1l7gQ4lyWXvVKhUEzbUW6p8mR+Vd0Rc7pFqjZRfmSs0u1+307lHvp0+BaCZTi/ZNwlEVmw/ByP+HpuIWEFkmaKJYzAUqH+K8VrjP1uP6EIkzpLz4jSFd72itxKBiUEM9Zk/1cssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foVuHP3i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foVuHP3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778761404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZDTcC/M4RXrGfR7t7dVuFEv8hWzJmh0dIOkGEhsUUQ=;
	b=foVuHP3iSdXrRlR2zh38tYmgkIAw0Xp1CfYpxqAwwr1nmiL6rBdXzSYWebiiScKwsuFRrC
	ttO46jOtJyFI1IOVExHVix55xBnLSV9nRPLCkmLeXwXIj6a9ktyoUC8WKefbI5ggeOWSVO
	vx5cevC9u/OKtQEOhUcNfy347YFZOco=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-Kdy4pbiDOyG_gKvcsfh8ng-1; Thu,
 14 May 2026 08:23:21 -0400
X-MC-Unique: Kdy4pbiDOyG_gKvcsfh8ng-1
X-Mimecast-MFC-AGG-ID: Kdy4pbiDOyG_gKvcsfh8ng_1778761400
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2612F180044D;
	Thu, 14 May 2026 12:23:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.46])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53C5518004A3;
	Thu, 14 May 2026 12:23:17 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: bhelgaas@google.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add D3cold as general reset method
Date: Thu, 14 May 2026 14:23:15 +0200
Message-ID: <20260514122316.23467-1-jtornosm@redhat.com>
In-Reply-To: <2c4dbba3-f9ed-48d9-a0c4-d590904f3fdf@app.fastmail.com>
References: <2c4dbba3-f9ed-48d9-a0c4-d590904f3fdf@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Alex,

Thank you again for your feedbak.

> This fall through is invalid, if D3cold can't be reached the reset should
> be handled by pci_pm_reset() where NoSoftRst is honored.  pci_pr3_preset()
> should be tested in all cases, not just probe.  I think we also need to
> test device flags that would prevent a D3cold transition,
> like pci_pm_reset().  Thanks,
Ok, I've implemented it as a strict method (only when _PR3 is present) as
you suggested for the next version. I think it can be very helpful.

However, I'm facing a challenge with a part of our deployment scenario and
if possible I would appreciate your guidance (spoiler: d3hot possibility
would be very helpful).

Let me comment on about this setup in our lab:
- Qualcomm WiFi cards (ath11k 17cb:1103, ath12k 17cb:1107) and modems
  (SDX62/SDX65 17cb:0308)
- M.2 format devices using passive PCIe adapters (not native M.2 slots)
Problem:
- No FLR capability on devices
- NoSoftRst+ set (blocks PM reset)
- SBR broken through passive adapters (PERST# signal not properly wired)
- No _PR3 ACPI resources for standard PCIe slots (only for native M.2/
  Thunderbolt)
- d3cold_allowed=1 but pci_pr3_present() returns false
Result:
Default kernel has no working reset method (reset_methods shows only "bus"
which doesn't work).

I've tested the D3hot transition behavior and this is what I see before/
after:
- Command register: Cleared to 0x0000 (device disabled)
- BARs: Preserved (0x84200004 unchanged)
- Device successfully reinitializes and works in VFIO passthrough, so we
  can use it.

I don't dare to generalize D3hot in pci_pm_reset() with something like:
if (csr & PCI_PM_CTRL_NO_SOFT_RESET) {
  pci_read_config_word(dev, dev->pm_cap + PCI_PM_PMC, &pmc);

  /* If device supports D3hot, try reset despite NoSoftRst */
  if (!pmc & PCI_PM_CAP_D3HOT_MASK)
    return -ENOTTY;
}
because some devices could truly advertise NoSoftRst+ and d3hot could not be
usable as a reset.

I don't know if some device-specific quirk could be acceptable to bypass
NoSoftRst check for these Qualcomm devices (similar to
PCI_DEV_FLAGS_FORCE_PM_RESET from v2), although d3hot is usable in these
cases.

Or maybe the generalization could be to create a user parameter to bypass
PCI_PM_CTRL_NO_SOFT_RESET for the configured device. This would be manual but
at least it would allow the device to work on VMs.

And finally, what I would choose: move pm to the end of the resets methods
ignoring NoSoftRst, prioritizing hardware resets first (FLR, bus, d3cold)
and using d3hot as the last resource if none of the others work. But this is
an important change and there could be some reasons for pm positioning that
I ignore, so if you don't mind I would like to consult you first.

What do you think? Could you help me?
I would like to address these devices on VMs in some way. 

Thanks

Best regards
José Ignacio

