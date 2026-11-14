Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794654211;
	b=Wb4sFIj33CmyPxwK5QmmMdFis+VG0d8Hki9hXHpfu5E4BgdKAmhfqMVsuHYfCYhTpf7q
	 6dA6Ad3hW+R1fOzEbwz6JvA7JmabgBOmE3mS82FLudNHIz6E6MlrHNbDi1oLGfhS7xpU2
	 LmY8gwhY+2uPqad3Y4Zkk40rD5L0ToPPweiFfkwjSRZKYfy5EyCJPmeyAAoyIuANszQtF
	 wJg1K+ogO1SiWON8LXZFGRfaBLjK6oacSQ8D1yWleNpEik0bPBEQ8OBBdkcpf4+IpGFcH
	 d9uh2JNnLXeQFt02gzdpdENNFHlEYRqc0nG2pAtqLoP7dN5/b63fry+rFWZ6Sea7bVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794654211;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bLje+BOTqYleanClAiZ+EcP5qh/Gh5/Z6wdmZukVivs=;
	b=ypGmb/sya0xmFxDCS+ywArGdIpgMHH5gsxgO4aG9Xeu2bamfpDePQh8Gk2ixNlgF8rWa
	 rMSkjL85xxOGGckZT1w1KxKItiUJ4slsQQg1bQEnnLCNrCC4X2cLFxCzMJTqdUJeVtI2X
	 tiduBxZPGQXR2ugPjw37HYtb12BoMJzdcqxvNOlnhTllWP6oY1NW9m13u2td2OQTIWInv
	 uatpP0hui4G0Rivk2TZVpENpkwDITZuVNL/3tZITCDgEhko/FrVcbb0z5+X2S1MimvNg/
	 0pJ3Ync1gLzSIO3u8poj5SUxVHNgEoo7BZIVPFaoIKqw5ZBZNHNllB8Mf9ExsdM4q3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzIpLSJX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10690606A330;
	Sat, 14 Nov 2026 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzIpLSJX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AFC1F000C4;
	Sat, 14 Nov 2026 11:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794654210;
	bh=bLje+BOTqYleanClAiZ+EcP5qh/Gh5/Z6wdmZukVivs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hzIpLSJXSEGH9fIUzxl3iTc2PYkjOpHs5pMHBu9XxoZKwHABEVhP/XjXa0Qw5ub6M
	 Ffm6Fx5pXxqGMDvleA8sJ8b+NG4CpxDacQI9yiGrWF0MheDgQHT/4E7bsf+tBbM9wT
	 G/Q1vBDbR55azwSXi0nbBSWxWUOtE1YJodDxpBiI/DWRe1uUxn4wHlIJoizZ6+WK7G
	 eSj4J7krrBQxY8W9+2D4Dj19afjS421b4FZV99KwG9oxjHzMYvbtpd0qwXwSJrkS2d
	 3adQBZloL/M7mHCOLIDwsyxnjyll22xHcnbabNdm6N9jkgGwCPaqpjLPpmgKwBImSx
	 NiC6SiLdZGpyQ==
Date: Sat, 14 Nov 2026 13:03:25 +0200
From: Mika Westerberg <westeri@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: lionel margueritat <margueritat.lionel@gmail.com>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	bhelgaas@google.com, mathias.nyman@intel.com
Subject: Re: [PCI/Thunderbolt] Intel Titan Ridge DD (8086:15ef): ACSViol on
 link-local LTR Msg (route 100b), possible ACS Source Validation false
 positive
Message-ID: <20261114110325.GA833643@thinkpad>
References: <CAL0aDZ_HOq1Sof90GJoBDzPo7Gmr7P_rSnYJaN75QH4K+iodpw@mail.gmail.com>
 <avdo5xUynQEQY22u@wunner.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avdo5xUynQEQY22u@wunner.de>

Hi,

On Fri, Nov 13, 2026 at 08:45:43PM +0100, Lukas Wunner wrote:
> On Fri, Nov 13, 2026 at 03:18:46AM -0500, lionel margueritat wrote:
> > [1532.142389] AMD 00:03.1 pciehp Link Up
> > [1532.273384] Intel 06:00.0 bridge configuration invalid ([bus
> > 00-00]), reconfiguring
> > [1532.280...] Bus and BAR assignment completed for endpoints
> > [1532.282964] xhci_hcd 09:00.0: xHCI Host Controller
> > [1532.824413] Intel 07:01.0: Correctable Data Link Layer BadTLP [6]
> > (NVMe-side bridge)
> > [1533.779213] Intel 07:02.0: Uncorrectable (Non-Fatal), Transaction Layer
> > [1533.779233] Intel 07:02.0: [21] ACSViol (First)
> > [1533.779243] Intel 07:02.0: TLP Header 0x34000000 0x00000010
> > 0x00000000 0x00000000
> > [1533.790681] xhci_hcd 09:00.0: AER: can't recover (no error_detected callback)
> > [1533.790732] Intel 07:02.0: AER: device recovery failed
> [...]
> > The packet appears to be a link-local routing 100b Message TLP with
> > code 0x10 (LTR) and Requester ID 0000. PCI-SIG ECN of 15 April 2026,
> > 'Access Control Services (ACS) - Source Validation Clarification',
> > discusses false Source Validation errors for locally routed Msg TLPs
> > (100b, 110b, 111b):
> > https://pcisig.com/PCIExpress/ECN/Base/AccessControlServicesACSSourceValidationClarification
> [...]
> > 1. Is the LTR TLP with route 100b and Requester ID 0000 valid on this
> > downstream switch port, and should ACS Source Validation exempt it?
> 
> It's a valid TLP.  The ECN talks about *optionally* ignoring TLPs
> like this one when performing ACS Source Validation ("designers may
> disable Source Validation").
> 
> > 2. Is there a known Intel Titan Ridge DD JHL7540 NVM/silicon
> > limitation, or a device-specific signed firmware correction? ACASIS
> > support has been contacted.
> 
> I'm not aware of one, maybe Mika has more info.

I'm not aware either.

> > 3. Could an init-time software quirk or firmware correction handle
> > this without weakening device isolation?
> 
> CXL has a similar issue when performing a Secondary Bus Reset:
> The Endpoint sends a PM Init message upstream with a zero Requester ID
> and that triggers an ACS Source Validation.
> 
> Fabio used to work on this, he's no longer at Intel and the project
> is thus paused:
> 
> https://lore.kernel.org/all/20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com/
> 
> According to PCIe r7.1 sec 2.2.9.1:
> 
>    "Functions must capture the Bus and Device Numbers supplied with all
>     Type 0 Configuration Write Requests completed by the Function,
>     and supply these numbers in the Bus and Device Number fields of the
>     Completer ID for all Completions generated by the Device/Function.
>     If a Function must generate a Completion prior to the initial device
>     Configuration Write Request, 0's must be entered into the Bus Number
>     and Device Number fields."
> 
> So we need to perform one Config Space Write before the device sends any
> LTR message upstream.  The kernel sets PCI_EXP_DEVCTL2_LTR_EN in
> drivers/pci/pcie/aspm.c, but I would think that we perform a lot of
> Config Space Writes before that, so the device should know its bus and
> device/function number by the time PCI_EXP_DEVCTL2_LTR_EN is set.
> 
> Is PCI_EXP_DEVCTL2_LTR_EN set by default on this device?  That would indeed
> be a silicon bug because the default value is 0 for the bit per PCIe r7.1
> sec 7.5.3.16.  Or maybe the platform firmware sets the bit?

We had similar with PTM, namely Linux enabled PTM automatically for the
PCIe switch upstream port and that made the PTM messages of the
downstream ports (that were not yet even configured) starting to send
PTM messages. This triggered same ACS source violation. We fixed it
with:

  e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")

Looking at pci_configre_ltr() we seem to enable it automatically for the
upstream ports.
