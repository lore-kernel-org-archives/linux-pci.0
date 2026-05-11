Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010240F8C5;
	Mon, 11 May 2026 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528210; cv=none; b=GQCg/OwFrna/yakdGV+oHAN3autitZDW5Awyp+VdXcOjgW3li5cZSeEGexsETJclhzhVejebwtS4o33KLhU3+jqYuPdjfPHK7lY7KMHVEPLKBgnTkjeiSqX/xi0ig2HoJXYcWRh9nypEPXSbTIWb/8C5gEcqI3joKzminAt4jaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528210; c=relaxed/simple;
	bh=XEyyVry+B5cgxniqCegnlxgWLtFKQmaUeIaqvotjvk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOUYr2ZVTeCNWbq0Cf56d0109MkYR29EZpb0broD1+BC/U0ExrvbTL2n4vzQg24i3y5F/PvlL7CFoqzCN63tcJKXAHYjsFlQGWo/exbDzknqs4dvw2tJsxWJ9FeQ0IFKJNHgKMPFJ8GIHINwGGeyV6TTyWbtb2SkqLQVlLBkS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=xTyqZI0i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkWViqx6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="xTyqZI0i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkWViqx6"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 46AA07A0058;
	Mon, 11 May 2026 15:36:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 May 2026 15:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778528206;
	 x=1778614606; bh=yUxu5Q32NyGO7Y1JN23+34pg9G6YULQJfyRq0babpSk=; b=
	xTyqZI0iIBe2/yNq2bc39zBYrC186oyNMQu9rmuaDJIuCPVVNfw2/eUSQHl2cXJh
	dvV+jxNRO09gw0zF7KLpsjD+4grVmLdLb/javjxVMPXvRziNoHTqmHRP/GnfXXIn
	QLxF3Ax1uc+xUJTWS6tEEPqVoKvJx5xov9N8tE/vmWUhOnv5W6kSd4ZXuc3xMdWz
	2nLx01sOn4TTZcdfT902WX50aI12uZezB6NfFsMlupZRgrc8PuKOzcOS399atkK7
	5tAO2rnC/ntVo1nsh3x6pUFm99Z0pQFFe53SrJfq4weMIA/qjifed5/OVaexSqI/
	RlhCagJci/Ipgf/pp9UIlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778528206; x=
	1778614606; bh=yUxu5Q32NyGO7Y1JN23+34pg9G6YULQJfyRq0babpSk=; b=h
	kWViqx6yGFpr2kALBY44je17rAzYk6PFX7uM7BNqQjIWYf3x9rPccGhUa5o+IqAy
	qmtV2USG+Px2bzyMxZb7EJ9/TYHG1u+H0c+Cy4gOd7eZ6+/Qr4dqK27VMDTCbAFF
	6pnwMAZS1XichA2eFxeiBOh4vMSoZG0bJoFEeg3oAd21IYK16Q22AL+SLdtb1qIr
	SR5hXgbVwHdmr1yg10My28kChScPngVMzSshqvg8UDApzZv3RDG8HK1zy9Y4ACX9
	TWoMcyu0L3kq9XPdZ3DElY9ASAFPml+2uv4ZPsF9mzXu4RCM27lq5uPJoq8BXOaR
	8jMD8+oABVUycEzxNDtFQ==
X-ME-Sender: <xms:zS8CakTYhJZyDmtUzjkPQLhPz3hermM_SLC1z3Q7kTXiPN2jIc2mTg>
    <xme:zS8CajRXLk0WRgOu4tazkCyW-W6UwARCm7B1ieQqxJtsTYRYRHWwk3K00rxQxyTpm
    6od_4Uab0qUU50pi4QOaw8mzJFHZmlYVeb147LNNDKSNA4wBOSDUg>
X-ME-Received: <xmr:zS8Cah6WGTDtwk7Aj2NeTQXYYZJDMI59v7JBcxSLEdmuVA05cFEsaSrRMN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeljeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepkeehjeeitefffeeuieetjedtje
    ffvdelledvuedvffdvfeetgefhveekuedvfedvnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhtohhrnhhoshhmsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgv
    giesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:zS8Can04aOM1vkTPlU9pTGL5Se1AekCs4H7BeVcdTKU5jcRkcfO6TQ>
    <xmx:zS8CakCjlUWTkqXXFzRVA3vhc2CiMFCxwr6NOdYOgx7ush2imn5l5A>
    <xmx:zS8CaqND0wdsHAzWmLEVi65Dysx-kyMPv3OTha7J9kKwfC18TH_G0Q>
    <xmx:zS8CahaZvyBDNdTOL6p94ed6eFstuopVvj9nDQGwE83l4r7ndR8zrQ>
    <xmx:zi8CagqTadGenEQn4zkSC3i_rI8WGKhryOP-ltIUryFoEw6h0PpByxOj>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 15:36:45 -0400 (EDT)
Date: Mon, 11 May 2026 13:36:43 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] PCI: Force PM reset for Qualcomm devices with
 NoSoftRst+
Message-ID: <20260511133643.73a16e69@shazbot.org>
In-Reply-To: <20260511122622.35311-1-jtornosm@redhat.com>
References: <20260508111627.702c9be2@shazbot.org>
	<20260511122622.35311-1-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 14:26:21 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:
                                                       
>                                                             
> > What does reset_methods sysfs attribute report for these devices on an
> > unpatched kernel?  
> The kernel we use doesn't have CONFIG_PCI_RESET_SYSFS enabled,
> so reset_methods is not available. However, I can provide the actual
> behavior observed through testing and dmesg logs.

What kernel is this?  I don't find any reference to such a Kconfig
option.

> > I'd tend to expect these are single-function devices where bus reset
> > would be available as a function level reset.  
> Yes, these are single-function devices (PCI header type 00).
> For example, here's the ath11k device:  lspci -xxx -s 0000:03:00.0 | head -2
>     03:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765
>     00: cb 17 03 11 06 05 10 00 01 00 80 02 10 00 00 00
>                                                   ^^
>                                      Header type: 00 (single-function)
>  
> > I'm very suspicious that this is just masking an underlying issue
> > relative to bus reset for these devices  
> Yes, you are right, there is an underlying bus reset issue. Let me explain
> what I have observed through the testing:
> Testing showed no reset is performed at all. During both VM startup and
> virsh reset operations, there are no reset-related messages in dmesg.
> The reset hierarchy returns -ENOTTY at each step:
>   - No FLR (device doesn't advertise it)
>   - PM reset returns -ENOTTY (NoSoftRst+ flag)
>   - Bus reset apparently not attempted

Bus reset should be used for function level reset of a single function
device unless either the downstream port or the endpoint are quirked to
prevent it.  I don't see any such quirk for 17cb:1103.  What's the ID
of the root port?

> When testing the suggested quirk_no_flr() approach (which worked for
> mt7925e), dmesg shows secondary bus reset is attempted:
>   vfio-pci 0000:06:00.0: enabling device (0000 -> 0002)
>   vfio-pci 0000:06:00.0: resetting
>   pcieport 0000:00:1c.4: unlocked secondary bus reset via: __pci_reset_function_locked
>   vfio-pci 0000:06:00.0: reset done
> However, the device becomes unresponsive after this:
>   lspci -vvvvvvvvvvvv -s 0000:03:00.0
>     03:00.0 Network controller: Qualcomm Technologies, Inc (rev ff) (prog-if ff)
>         !!! Unknown header type 7f
> And all config space reads return 0xFF, indicating the device is not
> responding after bus reset.
> If we use PM reset (D3hot->D0) succeeds and the device works correctly
> through multiple VM lifecycles (startup, virsh reset, shutdown/restart).
>
> > especially if we haven't actually verified the device state is
> > actually reset on transition back to D0                 
> The verification is functional: with our patch, the device successfully
> initializes in the guest after VM reset operations, and continues working
> through multiple reset cycles. Without a working reset (default kernel),
> WiFi devices (ath11k, ath12k) cannot be reused after VM termination, and
> modem devices (SDX62/SDX65) fail to initialize even on first VM assignment.
>
> Summary:
> You're correct that there's a bus reset issue, SBR breaks these devices.
> The question is whether we should:
>   1. Investigate why SBR breaks these single-function devices

Then why aren't we setting quirks to use quirk_no_bus_reset() for these
devices?

>   2. Use PM reset which demonstrably works
> Option 1 may involve firmware-level investigation, while the PM reset
> approach provides a working solution.
> This situation is similar to existing quirks: quirk_no_flr() works around
> devices with broken FLR implementations. Here we're working around devices
> that incorrectly advertise NoSoftRst+ (preventing PM reset) while SBR doesn't
> work properly.
> I'm open to your guidance on the best path forward.

Proving that an advertised reset method doesn't work is much easier
than proving an unadvertised reset method does work.  What's being
proposed here effectively ignores 1) while asserting that 2) then
works.  Does 2) work only because it prevents the fall through to 1),
which is known broken, or does it have merit on its own.  I can't tell.

Whether supported in your kernel or not, the mainline kernel does also
have support for modifying reset method priorities through sysfs, so
the fall through order assumed here isn't necessarily what everyone
will experience.

I would start with disabling the reset methods that are known broken,
FLR and bus reset.  Test whether that results in reliable behavior.

If that's still not as reliable as you're seeing by adding the
transition through D3hot, then I'd be open to the discussion of whether
these devices do in fact need a device specific reset or quirk to PM
reset (and everywhere else that tests PCI_PM_CTRL_NO_SOFT_RESET).

The previous patch[1] proposed a device specific reset passing the
device through D3cold.  This muddies the waters a bit because D3cold
will actually power off the device causing a reset, but the ability to
enter D3cold depends on the platform, not the device.  We can't tell
from the code what state the device actually entered there.

OTOH, the quirk proposed here would only achieve D3hot.  Are the BAR
values preserved or cleared immediately after transition to D0?  If
cleared, that could provide supporting evidence that NoSoftRst is
actually misrepresented by the device.  If not, we're really just
looking at a heuristic that an internal reset might be occurring, but
only the vendor could confirm.  Thanks,

Alex


PS - D3cold might be an interesting reset method that could be
implemented for single function endpoints in slots that support it.

[1]https://lore.kernel.org/all/20260507142916.392983-1-jtornosm@redhat.com/
