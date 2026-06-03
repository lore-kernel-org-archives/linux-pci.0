Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E447ECC1;
	Wed,  3 Jun 2026 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490694; cv=none; b=rGSd1iqP45ZVsyZo7/e6bgtkFuWUpTX3s9PkF+7YII3zieFGsKl3l4c3d/2mE8dA4u7UhuX33IEBX38vscJCSVqvqhcPdEn0GyzfF97TltK+ZpAUsZhAUP8c0y8yXWQw4V0m20SVrOw12Lgt2dASYtWt6tpx4fcNSvhHt2Jstbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490694; c=relaxed/simple;
	bh=lFBvHYlZhwPL57No0pMFcMgYeicKhRPvHKBsQwOso4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsQpkkCXN8xPzSgTwZAAYFJLebmyfL+ym4bwSDu66Tpo7WymFW5+S3QmyQJFQlaiKTVoheA9XBm5Ettl4yog4vH1iZXenjnk/CyBQMf7QMvEHwZ7GcBZtrA7Z1Sw3zX3aqI5dtX/1LZhhawOI7qotnd9FtnCRTuZwqrhGpyU9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id D331810E08;
	Wed, 03 Jun 2026 14:44:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B8DA960C92C3; Wed,  3 Jun 2026 14:44:27 +0200 (CEST)
Date: Wed, 3 Jun 2026 14:44:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Yingying Zheng <zhengyingying@sangfor.com.cn>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ?????? <dinghui@sangfor.com.cn>
Subject: Re: [RFC PATCH] PCI: readiness condition with Configuration RRS in
 pci_dev_wait()
Message-ID: <aiAhq-BO5baJBfVl@wunner.de>
References: <96e8ff0e-b538-42d5-a328-96515fc3fa9e@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e8ff0e-b538-42d5-a328-96515fc3fa9e@sangfor.com.cn>

On Wed, Jun 03, 2026 at 05:32:54PM +0800, Yingying Zheng wrote:
> However, with some PCIe switches (in our case Broadcom/LSI PEX890xx PCIe
> Gen5 switch), when the downstream device is in reset or link training is
> not completed, the switch exposes a Virtual PCIe Placeholder Endpoint on
> the downstream side. During this window, reads to the GPU BDF Vendor ID
> return the placeholder endpoint Vendor/Device ID (Broadcom/LSI) instead
> of the expected 0x0001 RRS-visible value.

What's the OEM and model name of the system you're observing this on?

We ran into this issue on a Supermicro SYS-421-GE-TNRT server with
AOM-PCIE5-418P-1-P board.  The two Broadcom PCIe switches are located
on the AOM board.

Do you happen to use the same system?

The Broadcom PCIe switches support a "Synthetic Mode" (alternatively to
"Base Mode") for use cases where a single PCI function is accessible to 
multiple hosts.

In Synthetic Mode, the Broadcom switch spoofs responses when the actual
device downstream of the switch is inaccessible.  The spoofed responses
come from the virtual placeholder device with ID [1000:02b2].

When I investigated the issue, I cooked up a tentative patch to recognize
spoofed responses in the PCI core:

https://github.com/l1k/linux/commits/broadcom/

After some back and forth with Broadcom and Supermicro FAEs, it turned out
that the switch had an outdated firmware with version 04.101.00.00.

The Supermicro server had already been updated to the latest BIOS version,
but the BIOS update does not include updates for the PCIe switches.
One has to contact Broadcom directly and ask for a separate firmware
update.  In our case, we received a file called
"AOM-PCIe5-418P-1 _PLX FW 4.16.0 Package.zip".

The zip file contained a g4Xdiagnostics.efi utility which can be run from
an EFI shell to query the current firmware version on the Broadcom switches.
It can also flash the switches with a new firmware, which was included in
the zip file as:
"AOM-PCIe5-418P-1_4.16.0GCA_PLX1_07172024.fw" and
"AOM-PCIe5-418P-1_4.16.0GCA_PLX2_07172024.fw".
                               ^
After updating the switches with these files, they reported 04.16.00.00
as firmware version.  In that version, Synthetic Mode is deactivated,
the placeholder device does not appear and reset on passthrough works
as it should.

According to the Broadcom FAE, the OEMs own the switch firmware settings
and so the kernel is not permitted to deactivate Synthetic Mode at runtime.

Because the problem was no longer reproducible after updating the switch
firmware, we decided that this is the recommended way to solve the problem
and I did not pursue an in-kernel workaround as a result.

As an aside, the amdgpu driver contains a workaround for Broadcom Synthetic
Mode which was introduced with 1dd2fa0e00f1 (and subsequently fixed up with
9b608fe94870 and 4e89d629dc72).  Obviously, this only helps if there are
AMD devices downstream of the Broadcom switch, and not with those of other
vendors.

Thanks,

Lukas
