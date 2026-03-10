Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B4A391E5D
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151735; cv=none; b=XAbZvo9hjkVHgu+Bb64UAKyNO18phUn1E3F8e/hNXTwE+8zXZiyUF2mD2FdOedzu84k00ULV2+53/QkQl63LYdUzoETB5LGn+6ea//VLARr1590Q4X9GYVdxRvEHEjzOi3OE9V10iKpLom1eyKUUEwL/KtZIfpiZZnQvs5tLl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151735; c=relaxed/simple;
	bh=42qlmNc9p/b+iwr4mkYqvVTr0+iIFCJTlNRxZygwQX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIxLHuERcJ7ZCqEwFDhTYYrEIccLb6yofECtgINhikCCgi2JWi3kTMy9hsZUPoXGA7lfLbGD9IrKIHHAin/FIQ6qNwPoLUwMOgT5tCnlV66oNyxDZZ8xIZ5Y4YDkrG7zagI6A5X7EhEBrvIZ1AmXhsYEFo0Cp/jHv9XW/Rkrqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id E71273F363;
	Tue, 10 Mar 2026 15:08:43 +0100 (CET)
Message-ID: <1a7a9d17-5086-4fdb-83e7-56d5ddaaadbd@hogyros.de>
Date: Tue, 10 Mar 2026 23:08:40 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] pci: check if VGA decoding was really activated
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260307173538.763188-1-Simon.Richter@hogyros.de>
 <20260307173538.763188-5-Simon.Richter@hogyros.de>
 <abAChDpsUQhpnOcT@intel.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <abAChDpsUQhpnOcT@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/10/26 8:37 PM, Ville Syrjälä wrote:

> Maybe this should also have a comment or spec quote to explain
> that it's legal behavior?

The PCI-to-PCI Bridge Specification version 1.1 has in chapter 4.5 "VGA 
Support":

     Bridges are not required to implement the VGA support mechanisms
     described in the following sections.

So this has always been optional.

What is a bit annoying is that I cannot find an explicit sentence 
allowing the VGAEnable bit to be hardwired to zero in that specification.

It is explicitly allowed to hardwire the VGASnoopEnable bit to zero if 
VGA palette snooping is not supported for downstream devices (Table 3-2 
"Command Register"):

     Implementation of VGA palette snooping by a bridge is optional. If
     VGA palette snooping is not supported, this bit must be implemented
     as read-only with a value of 0

That is the command register though, not the bridge control register.

The bridge control register documentation (Table 3-9) does not 
explicitly say what should be done if VGA support is not available, but 
the behaviour of the VGAEnable bit is a superset of the VGASnoopEnable 
bit, and the VGASnoopEnable bit becomes a Don't Care if VGAEnable is 
set, so "the bit must be hardwired to zero if unsupported" appears to be 
the only valid interpretation.

This seems to be the behaviour of all the devices I have available:

  - IBM PowerNV PCIe root bridge (POWER9)
  - SiFive VisionFive2 PCIe root bridge (PLDA XpressRich-AXI Ref Design)

Both read back this bit as zero when written via setpci:

# setpci -s 0000:00:00.0 BRIDGE_CONTROL
0002
# setpci -s 0000:00:00.0 BRIDGE_CONTROL=0xa
# setpci -s 0000:00:00.0 BRIDGE_CONTROL
0002

There is also a question in the Altera support forum for their PCIe Root 
Bridge IP at https://community.altera.com/kb/knowledge-base/-/345837 .

> The slightly bigger concern I have is whether we need to unwind
> the previous steps if this fails? Looks like we don't update
> vgadev->owns on failure (even though we may have partially
> enabled things). But since the bridge should never forward any
> VGA accesses, leaving some extra PCI_COMMAND enable(s) set on
> the device shouldn't matter in practice.

I was thinking the same, but because we're going upwards in the 
hierarchy, the bridges we leave enabled are downstream of the bridge 
that refused to forward.

I can add this for completeness though, that should be fairly easy.

> So I guess this should
> work even without unwinding. Well, not sure about
> arch_set_vga_state() since that's 100% magic...

It's not entirely magic, because after success from arch_set_vga_state() 
we still go through all the bridges. I believe uv uses it for some kind 
of paravirtualization.

    Simon
