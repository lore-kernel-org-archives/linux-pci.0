Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599154;
	b=0CppVZNqOKV2ak0g8GyrzWNaZu1yq1rYgG9iSEKzWuAgdrBW7wlKQkmxZa4xnu9oNpX1
	 cFoTr+mj8qtzVy4V4zkaIPXiaam2DsztWFAGcyYFzUmjqUrTAl0QLe6/5ihiv3gxRfTq5
	 x5o9CJIsAwSLCniQWaHk+wI1qSB2onqSYgypruKh6Fa0Kc6Smqm85ADDDq7Q5fXaWEDTk
	 m6c5+foX0CfwmsG3twCh7yoG9U9KheRHnPr2ery0EpVoMeczcr0C4+BYZ9i8VUYeklAuY
	 6Mlqo5SS5/s4x7cBRXwIK06xLrIwP+/iGyfomYOxcPujOjKhv/DulCPCnORDSlbozrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599154;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ASvXftBexK4DmELjjpF7dNc5SYpIr2SHmzpncUVYAkU=;
	b=GrxydGrluI+2JD7VNCd87Gfn3Gi2gllSi/TK0hbGFGSW4jyO44EMIdMLaSXhlmLnjvUX
	 sz0bS74pxNudpXxqzKJy0MNhnsC/z6F30afwYEiqU1rzlHhiv+7U4LMnu9ZpT8aDbnLu6
	 K3F33+/Xk9F4Qii9QQHf8xL9Ic3XkIWKLEZ1osc0zBX32YJXWpwz5f7PuRdVN/QszsWZm
	 3cj2MrYfxeQ/3ksY0l7QTSZpN4v5EfNDkju7oO9muErUnct+58cjvPfZfhNMssaonJIf+
	 Wrb2yPQRr5WSeH6YyUcesLyfpPIe8U+nCrep1rB5rOXA0BzsXeG3EL7HKmIhYPe6EgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B9606A330;
	Fri, 13 Nov 2026 19:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D7B9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id DB7871660;
	Fri, 13 Nov 2026 20:45:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 87B77603E12F; Fri, 13 Nov 2026 20:45:43 +0100 (CET)
Date: Fri, 13 Nov 2026 20:45:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: lionel margueritat <margueritat.lionel@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	bhelgaas@google.com, mathias.nyman@intel.com, westeri@kernel.org
Subject: Re: [PCI/Thunderbolt] Intel Titan Ridge DD (8086:15ef): ACSViol on
 link-local LTR Msg (route 100b), possible ACS Source Validation false
 positive
Message-ID: <avdo5xUynQEQY22u@wunner.de>
References: <CAL0aDZ_HOq1Sof90GJoBDzPo7Gmr7P_rSnYJaN75QH4K+iodpw@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL0aDZ_HOq1Sof90GJoBDzPo7Gmr7P_rSnYJaN75QH4K+iodpw@mail.gmail.com>

On Fri, Nov 13, 2026 at 03:18:46AM -0500, lionel margueritat wrote:
> [1532.142389] AMD 00:03.1 pciehp Link Up
> [1532.273384] Intel 06:00.0 bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [1532.280...] Bus and BAR assignment completed for endpoints
> [1532.282964] xhci_hcd 09:00.0: xHCI Host Controller
> [1532.824413] Intel 07:01.0: Correctable Data Link Layer BadTLP [6]
> (NVMe-side bridge)
> [1533.779213] Intel 07:02.0: Uncorrectable (Non-Fatal), Transaction Layer
> [1533.779233] Intel 07:02.0: [21] ACSViol (First)
> [1533.779243] Intel 07:02.0: TLP Header 0x34000000 0x00000010
> 0x00000000 0x00000000
> [1533.790681] xhci_hcd 09:00.0: AER: can't recover (no error_detected callback)
> [1533.790732] Intel 07:02.0: AER: device recovery failed
[...]
> The packet appears to be a link-local routing 100b Message TLP with
> code 0x10 (LTR) and Requester ID 0000. PCI-SIG ECN of 15 April 2026,
> 'Access Control Services (ACS) - Source Validation Clarification',
> discusses false Source Validation errors for locally routed Msg TLPs
> (100b, 110b, 111b):
> https://pcisig.com/PCIExpress/ECN/Base/AccessControlServicesACSSourceValidationClarification
[...]
> 1. Is the LTR TLP with route 100b and Requester ID 0000 valid on this
> downstream switch port, and should ACS Source Validation exempt it?

It's a valid TLP.  The ECN talks about *optionally* ignoring TLPs
like this one when performing ACS Source Validation ("designers may
disable Source Validation").

> 2. Is there a known Intel Titan Ridge DD JHL7540 NVM/silicon
> limitation, or a device-specific signed firmware correction? ACASIS
> support has been contacted.

I'm not aware of one, maybe Mika has more info.

> 3. Could an init-time software quirk or firmware correction handle
> this without weakening device isolation?

CXL has a similar issue when performing a Secondary Bus Reset:
The Endpoint sends a PM Init message upstream with a zero Requester ID
and that triggers an ACS Source Validation.

Fabio used to work on this, he's no longer at Intel and the project
is thus paused:

https://lore.kernel.org/all/20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com/

According to PCIe r7.1 sec 2.2.9.1:

   "Functions must capture the Bus and Device Numbers supplied with all
    Type 0 Configuration Write Requests completed by the Function,
    and supply these numbers in the Bus and Device Number fields of the
    Completer ID for all Completions generated by the Device/Function.
    If a Function must generate a Completion prior to the initial device
    Configuration Write Request, 0's must be entered into the Bus Number
    and Device Number fields."

So we need to perform one Config Space Write before the device sends any
LTR message upstream.  The kernel sets PCI_EXP_DEVCTL2_LTR_EN in
drivers/pci/pcie/aspm.c, but I would think that we perform a lot of
Config Space Writes before that, so the device should know its bus and
device/function number by the time PCI_EXP_DEVCTL2_LTR_EN is set.

Is PCI_EXP_DEVCTL2_LTR_EN set by default on this device?  That would indeed
be a silicon bug because the default value is 0 for the bit per PCIe r7.1
sec 7.5.3.16.  Or maybe the platform firmware sets the bit?

Thanks,

Lukas
