Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE85502D49
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745032; cv=none; b=SeVeyM9xRDWvzDbGxSjijGyCKyyPZYV2gPvv12n5G0kp6xyDEQH9FzfeetZNqMNP6ZgqDR5l5pjIYaA4wDsEGWymrwYLJIuXx85mQ/XQEYjfuhTdlW5OvfltIdmBam4JXFuJqG1/vwfTU6fwDCc1nSVvuf0OiLbvVgbDb82CZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745032; c=relaxed/simple;
	bh=Gw3zHBlfnMG0KsBOjIRgY29OGazqLY2sJsesKjOTX44=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Phw+bZouhR07ijgQpoCTsyHdgAIhUOEDXa2f6we93VVutIgbyGZwKrncFEBISdZg9JU3djvAGv9O6caOkShyRRaG3eYHc2i4NXCg/NYHG8LlFdcer6TIehBBYOQS3ALjrk/NQMhMVLTNqblOvxlV06NUoWXbfdNVLpf71YIabm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=K287R4Qn; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="K287R4Qn"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b88dc3bc02so789705e87.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789745027; x=1790349827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h9t3rJF/06ZDlRm69Ehr2E4atplDzwTzK8abOoc4YU4=;
        b=K287R4QnHyfU+XE5Q4mmXejZndaD+f5yxWLYQjEYIpkKtuzYSPRm1ZlCv7TARtz73x
         ZZG5Mj7qVZKIO7eZ4XG9dtFSaOivS5rddPJowjFmv0nfQFG9NDA9tlgG8OGLjQ9tFlvn
         hXRrgGkgXF+xUywYucdv8fzCWQfwHtvihBV89NYGcfqloEzDedHONukPfn2F+6aW3kZb
         +DM90fJp3EP0HMdaVsn2/x+fuqD604SURTgczYrXzZiR0ASpDdePOazrMtDE84qtexiz
         E0QpdEy2epi/t+N2dTRX8z+sw4MA0pzPfxEJ/nnDKzQ6XPeGj6Fmmu0m6tCpykjAj8Dw
         KdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745027; x=1790349827;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9t3rJF/06ZDlRm69Ehr2E4atplDzwTzK8abOoc4YU4=;
        b=Xxbt/Ttufo3V4r9wfqzfK/Ej6N4TqgDarQP2UKwchW+ZRw0tpxTehIJjAEEZCj9njX
         xk6tkYbn5Zzga4YAHrY+ItVvmG+DfOwglEuF05ed6haqXsQr3MKMplhpt53V/DTapORa
         IH1Cck8jvuIIJOCpWxsk/SR8qJXNeUNCw3WVhxwYGeUHl0Lz0C2Nq3lhVtMdnbwNgWn4
         BYnBorno9FIIVXPMrwkrvlc+CRyMZk2D3XT31m94zt0ioaKrORi2w81V2HhrkbUu+IKJ
         DTYtZvTUGbTlpYfYCpLWQJK1Mh77ofsklUGeueY5bHOVqAUK+XToddj5p83vX4MBIcPy
         2ElQ==
X-Forwarded-Encrypted: i=1; AKwUvBxb68bWX9SkA0krpiy4EWINslzxzfFrm8H3E34bX+qqVfz5xg+eXWFWlThG2lEg9mBpOufyDK76gsk=@vger.kernel.org
X-Gm-Message-State: AFuF++kzMsqMwk/QVWIZAS4+yad0BmplzULsqK22i0DDMirvCUrxfUcp
	3PsPpvpWNEPCC8exa20ZYeHiX5FeY52BvySquj/5oUdCsgcwhqOK/x9sAriCSzrJWBw=
X-Gm-Gg: AYBFou1RUzFCvmDMnH5paYNW7phngplaTD+gd2XawlGjMdDfpmOHoSo87KT46QAfqkb
	AII+t/QLLfjQpAGThMlK3NuZPUsA5CgXLGqwOS1666xLeAln4LulDhawlCm28bzkRQud4weTahH
	AoNAUUsPJKmQ0vFxctgqHqAlpQmre4ri0os91mYEr/M56ZGuHiP+lXDs86u5wqJX6UyHGb3wR0C
	GB9tR8EB68Ae45YAvQb/qHodbBCHzeYcPzpVCqXbmxkEWuKoZK1qbI+k/nw0ooSrbdPDmbyLoJs
	Gsxi1tY/eSW6aoxXOCw4ECOAjFDdNKtcbNJ3JIjEKvd53WTMYnIAmTS8Ie0WKLJ19QL9jfwv2sa
	NkMJhwPkPDMAWJttJ265ScPL+y6SU7yGOatYgbQ63MI4lqBS6ljzi/ysLG+oZtbjmh+DzDLhVCJ
	fYWB6KEiWfZb5ewyVFMEami9/vPckkNC3Jfd9hL4I1MRfpQ9PZa/TZxZ16GIAOY8gtto4DMis=
X-Received: by 2002:a05:6512:1389:b0:5ae:b969:417d with SMTP id 2adb3069b0e04-5b8c179c3b9mr1020325e87.0.1789745026603;
        Fri, 18 Sep 2026 08:23:46 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c274e5afsm547909e87.18.2026.09.18.08.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 08:23:46 -0700 (PDT)
Message-ID: <1105786b-7c2a-4f52-ba5b-324dcd68c094@riscstar.com>
Date: Fri, 18 Sep 2026 10:23:41 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] PCI: of: update endpoint ranges dynamically
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com
Cc: lizhi.hou@amd.com, herve.codina@bootlin.com, andrea.porta@suse.com,
 daniel@riscstar.com, mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
 mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260910021919.3421449-1-elder@riscstar.com>
Content-Language: en-US
In-Reply-To: <20260910021919.3421449-1-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 9:19 PM, Alex Elder wrote:
> A PCI endpoint bus is a devicetree construct that allows a PCI
> endpoint (function) to have sub-devices defined that are accessible
> in an SoC via the PCI endpoint's BARs.  Such a bus is represented as
> a devicetree sub-node for a PCI function having the name "pci-ep-bus".
> There can be one or more pci-ep-bus nodes.

Does anyone have any questions about this?

The devicetree pci-ep-bus mechanism defines one or more buses
under a PCI endpoint function node (either one per BAR, or one
node representing more than one BAR).  Being a bus, it depends on
ranges properties to translate between the local (BAR) address
space and the parent (PCI) address space.

If a devicetree node is predefined (as is the case for the Toshiba
TC9564 SoC), it cannot correctly define an endpoint's ranges
property, because the PCI address space is determined dynamically
during the PCI enumeration process.

This series addresses that by replacing the PCI function's
devicetree ranges property at runtime, to reflect each BAR's
assigned addresses.

There exist other users of the pci-ep-bus, and in particular
the LAN966x driver generates an entire devicetree node to
represent the PCI endpoint function--including dynamically
generating this ranges property.

This series intentionally reuses the code that generates
the ranges property for the "fully dynamic" case used for
LAN966x.

This series (or another doing something comparable) is
required for the TC9564 SoC to function using pci-ep-bus.

					-Alex


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
> 
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
>    https://lore.kernel.org/lkml/20260908213459.2519059-1-elder@riscstar.com/
> 
> The entire series (based on v7.3-rc2 and including those prerequisites)
> is available here:
>    https://github.com/riscstar/linux/tree/outgoing/dynamic_ranges-v2
> 
> 
> Between version 1 and version 2:
> - Included the first patch (which was previously posted in a different
>    series)
> - Modified the last patch so the ranges property is updated only for
>    PCI endpoints having at least one "pci-ep-bus" node
> - Rebased on v7.3-rc2 (and the prerequisite series)
> 
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
>   drivers/pci/of.c          |  89 ++++++++++++++++++++++---
>   drivers/pci/of_property.c | 137 +++++++++++++++++++++++++-------------
>   drivers/pci/pci.h         |   1 +
>   3 files changed, 173 insertions(+), 54 deletions(-)
> 
> 
> base-commit: 857c3561ea9f2c3107b5c6d830d3b3face159cbc

