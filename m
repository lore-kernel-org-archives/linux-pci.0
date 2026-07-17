Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E03BB669
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784331550; cv=none; b=A+EUnoBsxH1JZUYnWprNcfXwcf3XqwUr9Mf9hoSPKW0U/YPdrYs5MS9wF5XMCvjgktpvSm+m04uxfEASz39InVfakD7jk4zwzoxQ09UncvCHBNtzEZ6D9G6TB8P/WTDN9V2uI+d8u4shm+7IGWOFYA0pQqatSXiWBI9QQ88O7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784331550; c=relaxed/simple;
	bh=vSoFj0hBTT5p/CFJP12khF+A/hWJ+rXJdU4yKcto9Gs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EqBxvp8RJwRK2bnCOKB6MIN8aDOLLhgiRg2PLb4NFh0rBeS//2hqOJr72/0Mz4kbBihRvROd+de36cHBCxIN3yF/dRPyVfdPvjjkHc4+OhDpqpWf8r3/HuO21xiZOkxxx28jYQA5ReUzx5g2OM/6cem8DBXzRb1ZeKJXjCn9GJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UVmMpKhP; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UVmMpKhP"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90004d2f7b7so107926676d6.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 16:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784331540; x=1784936340; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jOQMW/VMMZhI1OvT3xpmRY3tlZwPV7fJgB6bntOIi38=;
        b=UVmMpKhPE7+0eIuWONcVoDM/c3k0TXLDTIkx41vcl9j0vEr6oGAGOnYuXQBHvylm4V
         qp+h8891y/otRXPPak4AXYWJuiK4L66+jdLgTFYeClWLQ+EUxUjssD5lYaISkb9EaMnP
         y2AZfeHgJBSuwLuBxxWJuOpuUpk3rTHwe7p+sEFV6elGRKbCskCH0bUWhZYp9TQRjXjW
         yQA4rN+LNbQ70I0WReDDNWJz5d8ruAxQl9X2wFPfdD1aZbHW6ltWMLPbCZ60xwV/3RLC
         YdfdwnIwN8mntNrDIOUveLsAdFAovG69mAVqogREHjZVsauugOx8FOgJ2PVjeylLwKhJ
         D+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331540; x=1784936340;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOQMW/VMMZhI1OvT3xpmRY3tlZwPV7fJgB6bntOIi38=;
        b=an5nibf6rVng6HnbQXintr7f8pGJ3KzfUihZMuiRHYLvhBZcBfOrDZEkk724xcYXL0
         D1+ZOd57Lxu8Slm29Cqge5l2iXTvR/R54PNJB0ODc6AeMcIQ+BqMIkcPSSryQAfTlW4J
         K7Nq955jYXaRmUYty0z3mBY+K5hSXeULJZs84bmOUHL7H/7eBwf75YMDM6v7PXhRJXXn
         NxIM5R2TxSDBquoN8S5ynOdWT3j6tMmcvozuOuyKYCqSjrPEZ3cwnRb+L5PrqUuSA+CL
         yQ/Uui6+CaG+AR+CvrHSWjqd9Howha4syICc9iDELSiAPPaUjrbsiPmvJz5ayU71jK04
         OQAA==
X-Forwarded-Encrypted: i=1; AHgh+Rquo0wqKdpES0K4dROVsIyxD3Du2UeH+DiVAs7kWY0bVtW8JWGoceTkvOGxeQ+7LyoiwEy6wjSP1sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1V2dbtQlsF7FtiIVW6vo94VByWWuvqRPvWMh2qnl3aI4BH+f
	poi1ZY1lrBCrNRLKUzqJ+umbVuofnWmgK5iXaIS2hNST3Ho4GklgBs9jE2RV4+Ses/o=
X-Gm-Gg: AfdE7ckMXRmIASmqJuQprHBX3JdNbH65tAx/SpC7it1dl1KEXa3Ef4DBz1WbdNqrts4
	L+0hzUB6Vt05iQyULaN80P/EUc1taIr6gHmKbUJ8/he6jh77HoR7VfX6PbgWoTSNzz6BkRYNRag
	KXsaJ+D5lippdpMO4l+lu46bSnRpCS7GFm6WlXLKJJu/0zXXm85ST7SPjgYN0LH3oV0NYUeIPko
	o1oudq6tQtwvhc0ce+1u3kID6ZA4hjSCeRTXbXz+oAYlk8rikDTYiPf/UcLTUWDOoQhHa9EqvDU
	Ds1XSJoio8lrnSsBuhgXA2u6PxIQ1Vl33pApAu0V9sLv+YoqUVf/6YeBBQCr9Vk4I7JFxmnthJY
	GMysmPxFixovJKmEsWnWoEAy9Dbe+pM5himN6QgYTqFQe+LZcRSw/aTx94IlNMcK5nIejL+K0nX
	vM56/GVhW+5iSbsA0SnWjxjr0N0VkrYG68DRAIQns=
X-Received: by 2002:a05:6214:5d08:b0:8f2:df9c:3322 with SMTP id 6a1803df08f44-9077832dd0emr59277606d6.14.1784331540051;
        Fri, 17 Jul 2026 16:39:00 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786f79e1sm28353026d6.38.2026.07.17.16.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 12/12] Documentation: PCI: Add documentation for
 Live Update
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-13-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-13-dmatlack@google.com>
Date: Fri, 17 Jul 2026 23:38:56 +0000
Message-Id: <178433153669.189683.2878214157071313722.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=vSoFj0hBTT5p/CFJP12khF+A/hWJ+rXJdU4yKcto9Gs=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWr0SpjC+L15xuM1whuQrxtevTro4lUduG+wQx
 gZjJKCgnxeJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalq9EgAKCRC7dyhM23N6
 3hr1D/9oIctf3jZFaNFf/Pf9J2Q7CfddVWZ2nNZ2arIAM0OUwhaxiAs+LtuvHStvp4Lzy79OaPC
 MNsK4RZArZ79NaLPOR9S5E6dP8SihdNKm23FpYWS8kmNKUvlpnvUn96H2Bo1thrOScdtHk8KXo2
 7hSeP/+8USMLy/ZHr2ShtiB+g1UAd176dG+ifwhSmAAgPmd16B83riVzBB/kFOwP0PXrnOHWCVg
 NoyCSnhFa7Oj1iHgWlBLPNUv1deka5wHUy7CtHqHc73wIsD+RDeq2t9Dnauotw051GQYm18pWKa
 Ro4mNfaV4/bgXOl+EindmOYLeL4vmRfgF/9ZiKkyjLjZcj7FGt7HsIhCwwbT/u2+A8OkOyGoZYi
 r1Iwow+abKmLmqHeqRIFjne6kQTJb22jxEEb/ezTHqlg26zjd2K/Z1L1frMnEuyd/6lmTpda2my
 KRnfdxmtZtL9QDtYOyUNtLuaOuwzNTTdod6HZcSVYGSUrQl+jbcegXb4vAnwsS3vURMyxjiGKME
 rn/hi18xZaZXcMv99T6EuayIMn8QHlfKaxv/XQG2mzCxdePpLOJp5QQlK322veGWDifJAyrkoRP
 XWQu7Llfgoiq2whZiWSbBSEkh55X60dfTNM06+VWWl86F4nrUoLaQGJti/70J124jfGNFISbW/A
 zR5q4Zf8lKCRE6g==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:15 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
> new file mode 100644
> index 000000000000..eba55f8a92ae
> --- /dev/null
> +++ b/Documentation/PCI/liveupdate.rst
> @@ -0,0 +1,29 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +===========================
> +PCI Support for Live Update
> +===========================
> +
> +.. kernel-doc:: drivers/pci/liveupdate.c
> +   :doc: PCI Live Update
> +
> +Driver API
> +==========
> +
> +.. kernel-doc:: drivers/pci/liveupdate.c
> +   :export:

I think you need:

+Internal API
+============
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :internal:
+

In order to include docs for structs such as pci_flb_outgoing, etc.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
