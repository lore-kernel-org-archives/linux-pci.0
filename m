Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BC353A7E;
	Tue, 11 Aug 2026 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483873; cv=none; b=tJ2ir9dkIQOXE+Xk8GvJzTV1CPDLnE0E2A5MyP/Ghg9UIsCUz+oShOu0vsiWlZaXJQjs6QLgRDDgwvw0RtV+FpO7lMgD8vrpwGv9iMzXqEnQF50bl8vP8OmO9/RWdWXaEGT376IyKh5h9RUIVrDA85u7hDXgA+jfVpSK+3be04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483873; c=relaxed/simple;
	bh=mgqN/AWASF09/wUke41fqUY2l81S38h13Mw2AwFq3Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kNzs6KvIV+oE8PGxr1MhF6HU+w4lL+sC5fADjOZxFj94cmrQ6y5nDRXW2X4TmXYDo0kYUaUFG9Rt0kaBw8kLQXR4NDOI/YCba0sZHmocOECqd3I8Hj6NjaOKuilqwEsy9liXPga7+PMgw+SVDIR0jqrWJAr5K9Ri6xcJ87Ka7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhAAIE3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhAAIE3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B000B1F000E9;
	Tue, 11 Aug 2026 21:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786483868;
	bh=fgomf3OxQMJ0XaTGNcMUjOJnKZRCWXcp1zfIgodCWmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZhAAIE3Jknf1hk9S3z35dbF1EOgKcBtaaKAHFVrHF6GLMCgx1oasWLw+KsGly5v8G
	 eOwOAML1pl7Xkp2Q1WuhOZEk0p/5o05jjD9FqzIB+RgMuMhQdKnZy4xOWWOc1Txn9p
	 7zVYsYFozGgz3gVPf3PEGtP+gLWtZHkyrA589N838btuVxPfPTiIgTJftJzl/kELDJ
	 8x23aMvwaNhmkP5cRhuFlGh1bJwyDabvASuPVTx1SbNqQFFAoR1D0Sn3oi1l38UscL
	 NzSOvIyxIHvMwaeIL1Mq3nWGXaUesVwBHpneC1qF1fi48MSvzV6qyHZQsszwqwgZkk
	 IGE5SWgxAH+DA==
Date: Tue, 11 Aug 2026 16:31:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Max Stevens <thinker.healer@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, nathan@nathanrossi.com,
	nicolas.cavallari@green-communications.fr,
	linux-usb@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: Re: Pericom PI7C9X2G608 =?utf-8?B?KDEyZDg6?=
 =?utf-8?Q?2608=29_missing_from_ACS_quirk_?= =?utf-8?B?4oCU?= breaks Renesas
 uPD720202 USB3 cards when IOMMU is on
Message-ID: <20260811213107.GA758429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811212835.GA711008@bhelgaas>

[+cc Tim]

On Tue, Aug 11, 2026 at 04:28:37PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 11, 2026 at 05:57:33AM -0500, Max Stevens wrote:
> > Hi Bjorn,
> > 
> > Thanks for the quick patch. I tested its effect on my PI7C9X2G608GP
> > (12d8:2608) by replicating what pci_fixup_pericom_acs_store_forward()
> > does, using setpci at runtime (I have not built a patched kernel —
> > happy to do that too if you want a test of the actual binary).
> > 
> > Findings on the 2G608:
> > 
> > The mode register exists at the same offset as on the smaller
> > switches: upstream port config 0x74. Value on my system before any
> > test: 0x0102 (store-forward bit clear).
> > With ACS on all four downstream ports set to what the kernel normally
> > enables here (ACSCtl = SrcValid+ ReqRedir+ CmpltRedir+ UpstreamFwd+),
> > and 0x74 bit 0 CLEAR, device enumeration on the downstream xHCI
> > controllers fails: [43069.603242] xhci-pci-renesas 0000:0c:00.0: Error
> > while assigning device slot ID: Command Aborted [43069.603270] usb
> > usb9-port1: couldn't allocate usb_device
> > Setting 0x74 to 0x0103 (bit 0, store-forward) with ACS unchanged, then
> > rebinding the xHCI drivers: the same device on the same port
> > enumerates immediately and works fully: [43071.971147] usb 9-1: new
> > full-speed USB device number 2 using xhci-pci-renesas [43072.132176]
> > usb 9-1: Product: Azeron Keypad [43072.218656] hid-generic
> > 0003:16D0:113C.0017: input,hidraw12: USB HID v1.11 Keyboard [Azeron
> > LTD Azeron Keypad] on usb-0000:0c:00.0-1/input1
> > I toggled the bit back and forth across several driver rebinds. Every
> > "Command Aborted" failure I have logged (both today and across earlier
> > debugging) occurred with the bit clear; none with it set.
> > 
> > One honest nuance: with the bit clear the failure is not 100% — I saw
> > one enumeration attempt start successfully during a bit-clear window.
> > That intermittency is consistent with the load-dependent packet
> > buffering behaviour described in Nathan's original erratum writeup,
> > and with this card family's long history of "sometimes almost works"
> > reports on various forums.
> 
> If it's an improvement, I think it's worth applying even if it's not a
> 100% fix.
> 
> > So on this hardware the store-forward workaround behaves exactly as it
> > does on the already-quirked siblings, and the patch looks correct to
> > me.
> > 
> > Tested-by: Maximo Paulino Thinker.Healer@gmail.com
> 
> Thanks for doing this.  I'll queue up the patch below for v7.3 without
> your explicit tested-by because quirks run at different times than
> setpci, and the timing/ordering is often important.

Actually, I take that back because the same patch is already queued up
from Tim Harvey:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=virtualization&id=062fb7f816439da6bf3860386889343482a66bd4
