Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F84E13E0
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958259; cv=none; b=CyNHKeRgCY6B/3hsNLDQcMhjrMNG8PWKTUYtE1x3Oi6JzKKv04SLwzxFLGWxeCha2RGz6JqV16tuRt88vTlFGHdLQO/htlGWFt+Abjj5yZolVI7DiDNnldgl6oO/UAMoiA6B64xqhSh7MuU+pFugyvubz6W1DvqhvFHblnJ0mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958259; c=relaxed/simple;
	bh=Em9YSoXBwFPJOOXkkk+kejVq9hjQu0Hx9vnOhF72eXw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nWAm7d/ktZ+If+Q0wUekiheoiDNMioD4mO0cRlIbeeU28vwQa3Vt58oIbvH++PmqY5OW9BHim1uBrYabx/0KabTpyUrroszLKkpTCnEa/ZFRVkfJZ1KKxGA9b3Q5tHH0LrGgrQc54lteF3BHgtva6xItwgMm7kM4HSSz7epBM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=M8qR7Aur; arc=none smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="M8qR7Aur"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-5337ecb5b48so30097411cf.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2026 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790958255; x=1791563055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvLqfhY0ukuw4SdFaafcEp7mq0hCjeNOKgF1sxMSOZI=;
        b=M8qR7AurJc3hUmhB2ze/+wKn6T1tRXpma/jwWDhaUaWd8XvMOTiQO01CBWSU7LnKFx
         30DbMdNcHbPo+az7zdmq+OhTWJUT/jRsdnlWDVXwUBaXg2D09KoCw2ltvld3Q3MJS4Nb
         /ZIPWzUMDB+GumdG3OiDkHvm7jrOk+KGEUBZ1JYFLatPve/X7x0ZLfEGldDSn4qcCPpt
         ooYoLg+OadNeXF4YCWXZiNqdVONxmaXezbOaadxXQfGPlRbjJ1Z+QyMDtfPfYpofBRnC
         KUX6D7m1OwTw/XLdQcJpOqI3b6Ldls6mT4PmTZ6OSZvjf9/f4ZTexaNhwrFPmcaYfU6D
         f5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790958255; x=1791563055;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvLqfhY0ukuw4SdFaafcEp7mq0hCjeNOKgF1sxMSOZI=;
        b=2sJocrRJM9irWi0+5pipJ1QmJR2VuuwjEBKwW7dQ5gmcQa0QfCCLZWojMVO7AhuTb1
         0zUqoDLqWptXn5qW4ABXAGTMGex5cO9I5v/jSSP/dtxFYPP7hKJGbidgENmeK5ywnOY/
         L9PnxSBCD5QiR8s8bNpO1NqQsT2mJZ1rY0HpJEVYsxN7m75M14NUbyD8uxfT4yY7faaK
         vFvkXEkS6Gc/GLrGK5ORUwfc1zoxumzAJmNX1UhoqrFuAMjv55b56RgLQoi4LRPj1hTB
         o81yYTE1Urw4BtzEylRzQQJRfR8Lrza63e7JGB6OrR6sHC2nCKIky02WeVfRhxfN/Waq
         WRhw==
X-Forwarded-Encrypted: i=1; AKwUvBwW53JMSEv+S5u/qGnCt8HlZVycLTf9DTgu5jHl1FL5xrVgoO6nAJT6cU4e56EXuA3yYv/n4rYsYG0=@vger.kernel.org
X-Gm-Message-State: AFuF++n32TLRUpSBtBpLISboj+pgktPMPO9+rqxW7UYVS8Fv+sGZZQ0W
	o6T86JDybOhFqr4VQoapOjuTc88asGdCpAzvqTRqC2juej+FCfDy65QcEIn9kPIi9ig=
X-Gm-Gg: AYBFou0pScBm2ZMoGilQzKTrL347u+OFwusEomvLp5z5/RAtrIorJZQtzWxrT2T1u4t
	22ATcM3tG237PY6AGLn8mssF4O54iZDJI0dqg6AvzBGHmsT1MLl5+jH44ykXTaZkQN7z5+BGYfy
	Fh2a5YBJwKqsqe3/WBzuWavS1C3oIHdlzT1JHI45gBi4MTJn4JxMx8oTzrO39vThZTGfPZ0CXiG
	gDKnZsTkaWsmApfaq3w1dqTrS083lq3pE304GuRFRSL6w0DvrQ8q3Y4mDgnulIzw3ci0DaQN1lJ
	W9VWWK0Qr0Lq3SfMGz8OPxZnhcvsOTEKo1S6M72EUNEfyOQXCb5O+QkNPJJuFBq9p0+61C6JdyF
	5LkXOd1ubF11egFNEgZu9mLytRTREHlWoBx63QxSY3YN+SIQbYgLY1MpQ2ByCixxpSuUqcU2Chb
	zCNK3jYcV7m8hJvvcZcwwm/Uz7jHmrdPYJYy3JCE9xQ22A+O+gSmtbQJGiK2DA00pgQL2Ryso=
X-Received: by 2002:a05:622a:1244:b0:533:9686:a051 with SMTP id d75a77b69052e-533cba41c4fmr52681091cf.21.1790958255002;
        Fri, 02 Oct 2026 09:24:15 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398bdd010sm30887341cf.19.2026.10.02.09.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 09:24:14 -0700 (PDT)
Message-ID: <a8141ee4-00a8-4059-8784-6b3fde26243b@riscstar.com>
Date: Fri, 2 Oct 2026 11:24:12 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] PCI: of: update endpoint ranges dynamically
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com
Cc: lizhi.hou@amd.com, herve.codina@bootlin.com, andrea.porta@suse.com,
 daniel@riscstar.com, mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
 mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924222444.1351466-1-elder@riscstar.com>
Content-Language: en-US
In-Reply-To: <20260924222444.1351466-1-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 5:24 PM, Alex Elder wrote:
> A PCI endpoint bus is a devicetree construct that allows a PCI
> endpoint (function) to have sub-devices defined that are accessible
> in an SoC via the PCI endpoint's BARs.  Such a bus is represented as
> a devicetree sub-node for a PCI function having the name "pci-ep-bus".
> There can be one or more pci-ep-bus nodes.
> 
> A PCI function with a pci-ep-bus devicetree node must also define
> "#address-cells", "#size-cells", and "ranges" properties, to specify
> how endpoint bus addresses are translated to the PCI parent bus.
> 
> An endpoint bus address has three cells; the first indicates which of
> the function's BARs the address is associated with, and the other two
> specify a 64-bit (2 cell) offset within the BAR's region.
> 
> BAR base addresses are determined dynamically by the PCI enumeration
> process, so generally it's not possible to include them in a static
> devicetree file.  When this addressing scheme was introduced, this
> was not a problem because the devicetree content was generated
> dynamically--after booting--based on the information (including BAR
> addresses) available following PCI enumeration.

The PCI endpoint bus model implements an addressing scheme that
allows sub-devices to specify addresses relative to the base of
an endpoint BAR.  This avoids needing to know the address assigned
to the BAR, which cannot be known until runtime.

For users (such as the LAN966x) that rely on dynamically-created
devicetree nodes for PCI endpoints, the generated ranges property
already incorporates the assigned addresses.

However if a PCI endpoint is defined in devicetree statically (as
in the case for the Toshiba TC9564), its ranges property must get 
updated at runtime to reflect the addresses assigned by the PCI 
enumeration process.

The TC9564 requires the functionality provided by this series
for it to be able to use the PCI endpoint bus model.

   ==> Would someone please consider and comment on this change?

It reuses the code that generates the ranges property for
dynamically-created devicetree nodes, to ensure that the
static and dynamic cases are consistent.

Thank you.

					-Alex

> It is possible (and in some cases, necessary) to define the devicetree
> nodes that represent PCI devices ahead of time, in a statically-defined
> devicetree file.  In order to support the PCI endpoint bus model in this
> case it is necessary to dynamically update the static devicetree so that
> the BAR base addresses assigned during enumeration are reflected in the
> endpoint's "ranges" property.
> 
> This series implements that dynamic update, leveraging the same code
> used to create the "ranges" property when PCI_DYNAMIC_OF_NODES is
> enabled.  The first patch makes an argument to of_pci_get_addr_flags()
> optional.  The second patch separates the code that dynamically builds
> the property value into a helper function, and the last arranges for a
> statically-defined devicetree node for a PCI endpoint to have its
> "ranges" property updated (if it includes a "pci-ep-bus" sub-node)..
> 
> 					-Alex
> 
> Note: this series is built upon these patches:
>    https://lore.kernel.org/lkml/20260924150222.1179235-5-elder@riscstar.com/
> 
> The entire series (based on v7.3-rc4 and including those prerequisites)
> is available here:
>    https://github.com/riscstar/linux/tree/outgoing/dynamic_ranges-v3
> 
> Between version 2 and version 3:
> - The ranges property for a PCI endpoint with an existing devicetree node
>    is only updated if its ranges property has an empty value (i.e., it is
>    "ranges;", or is not defined)
> 
> Version 2 is available here:
>    https://lore.kernel.org/lkml/20260910021919.3421449-1-elder@riscstar.com/
> 
> Between version 1 and version 2:
> - Included the first patch (which was previously posted in a different
>    series)
> - Modified the last patch so the ranges property is updated only for
>    PCI endpoints having at least one "pci-ep-bus" node
> - Rebased on v7.3-rc2 (and the prerequisite series)
> 
> Version 1 is available here:
>    https://lore.kernel.org/lkml/20260813220717.1394644-1-elder@riscstar.com/
> 
> 
> Alex Elder (3):
>    PCI: of: make a flags argument optional
>    PCI: of: introduce of_pci_build_prop_ranges()
>    PCI: of: introduce of_pci_update_endpoint_node_ranges()
> 
>   drivers/pci/of.c          |  94 +++++++++++++++++++++++---
>   drivers/pci/of_property.c | 137 +++++++++++++++++++++++++-------------
>   drivers/pci/pci.h         |   1 +
>   3 files changed, 178 insertions(+), 54 deletions(-)
> 
> 
> base-commit: 6ba8359b84d69a07d508693551ed3f661d838e9f

