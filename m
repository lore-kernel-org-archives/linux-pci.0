Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BFE282F38
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850722; cv=none; b=MDzXt9NyvJBdmGIOV6KuGi1VtXZP5QnJw8WrqxgEibbjrqgqm39ZVuIIpUuaBZriygc79fweM9KkWKvRKBEP/WM/e5f7P3AmCWCe2t8+lgUTgpe3rj6XhocZydKgC54Fh+vLnomU2ninSOSKwZWUyaGwVARTUidHwnecl3D5wwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850722; c=relaxed/simple;
	bh=mtNrxxMixLSJ5IBYSZLOCEDNhvuQ+B9NEif7MbnZofM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TonEn9amzOuPySSPcYwb1d8dkVn/e0nxCuFWXN7JacbqxVnJvX5u2W3LwP5wHHbU6Twgtm/zW11HB3NAxVGsHzj49oogjScYOpnjJ4V6hxzO0nO2SXre15gUsxlg63lBEJGGExnTBAWEKXE9SCtSiERjGilLYv8tHPx4prgjmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQHff5z/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQHff5z/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc73e322dbso23216725ad.1
        for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 03:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783850720; x=1784455520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vtBVbtAq8/J9WfLZAmtmwFvAK1PPs6W2XE0Zv0PL61A=;
        b=dQHff5z/H3bHMzRewQ0dlp6gDitHW8Zd75KBRsfTr7P/u4qAA2ekwyb8+47w1zc4Ai
         Yl7ej/B1ghM5RrF9YDkBkM9NaBcytk+89SnKUhK+iWuT7+QdoAG1HAh5SsU/hHC2tvjF
         +62vR23J8Pb6F/bs+57bqCmuzHRL/w+ZEB4sAseTLaVDmuqtFpyE7mo7XJG20fbcGqQw
         3fyN2vPcIs3iloX9JzSimTTXdLEyBSSg9TPMWOHAb1vKf3Qg5Riu9Odj5AJ+sFao6GVc
         3Lbbh0ygdRJBqAdB+UVOICLbant29cZQ+jAl6hhpDg9R88y9lBKIXnvyrziqg3ySMla6
         JT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783850720; x=1784455520;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtBVbtAq8/J9WfLZAmtmwFvAK1PPs6W2XE0Zv0PL61A=;
        b=WhGK8K3IGZOyTMq8dByHH7ApUUnZKneHS2tJkCD1C+I+jntCsOUu1wFctVR5sKcioz
         7aiqi5w3KmsY9BeQtR/IhvbN4x1t8V/GUiH15bJBsyr1hTUgOYKK4tVFQ8GzXWe0fdR2
         MZSEGusoOfOo7q+EqD139c3QNl8GSYm3jliRzt88W/fi39JL8ao23xSUopfxAl0KVvCE
         vFDtxXQZvV7CJq9YAj0VBq2mMZ8GuYWBKzU6oOIFtg03Y8P2SBoDgdwZiz0tpftKs/Lf
         uUzxLSOXCv8FQQX0qWiwmneY1ftSMTVj/kMcLs1Y6sgHkOClAZNIAVhYb6jfUyoxhpMH
         +eDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5KoC39rnSEpfpgKRV+xAgDoR+C64fnPNazBSwao+DWNWUNidzJPci5+hX8gUaJVbMcTfu3xH/YCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZ6U7LqM13V3tXpT1p6AsF7Tchdcn4GHWgUfz/Gq8cBQhaLLL
	tzHtanWZm0rfoyP7thrRSZ49Lq/c0ssOSagC1YcuEwDAkbllUE9DJRA8
X-Gm-Gg: AfdE7cmqy4qNcH46FpJt7nQK3WznUHUkoJC4OItEtc9dhrMnPmm93EEZDBNosHdX//J
	6zRBbV9eBfkRVi3Z1Czx5yLUIL7M2ztVYadleJuWe51n0rvqqWrKRedhakXPLkanRZV71Cb4mbe
	4vM68RMqUDnIOJs8dYKVFyTjSt5JdBFZ3w7ocIM3hMprV25b3C2W9dRhV9l87+Kxhr+mL/OTc9E
	ZW3zR4luB9lplhF1GNgtULReVi4CjgXL7MgmvbGadNo/q5LtlKg0N5wi48lBVVug3PXQ/mAQMXc
	CYATrxFcd1YI75wrMSnMEfHE06jJDm6WJ5RkVnJjsU1Q+8WGgoNmB5ewIHSCWcKPSPj9yHyyc4N
	rUFWeZsRGQa9hNtoFGYvOD9BYWDEv9WLDj7NzE7eQ5oQWnkfxStWkrFXX87xtuALn
X-Received: by 2002:a17:902:d987:b0:2cc:ae2b:b6d2 with SMTP id d9443c01a7336-2ce9eac1d98mr54983735ad.15.1783850720120;
        Sun, 12 Jul 2026 03:05:20 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf77e4sm83401535ad.22.2026.07.12.03.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 03:05:19 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:04:35 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Bruel <christian.bruel@foss.st.com>, 
	Frank Li <Frank.Li@nxp.com>, Nam Cao <namcao@linutronix.de>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Alex Elder <elder@riscstar.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 2/6] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <alNjykt9ERnMXTZ7@inochi.infowork>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-3-inochiama@gmail.com>
 <ak9KzNFF26B0Kttz@ashevche-desk.local>
 <alBNXgMAwXPKwiJ2@inochi.infowork>
 <alCoTEDUY8AO9OzD@ashevche-desk.local>
 <alDNlfb0_T9g-ATO@inochi.infowork>
 <alI6ml4xQboFOgxG@ashevche-desk.local>
 <alMmkHrfgWoN8RqS@inochi.infowork>
 <alNf1OoBtscauPXV@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alNf1OoBtscauPXV@ashevche-desk.local>

On Sun, Jul 12, 2026 at 12:35:16PM +0300, Andy Shevchenko wrote:
> On Sun, Jul 12, 2026 at 01:41:25PM +0800, Inochi Amaoto wrote:
> > On Sat, Jul 11, 2026 at 03:44:10PM +0300, Andy Shevchenko wrote:
> > > On Fri, Jul 10, 2026 at 06:55:10PM +0800, Inochi Amaoto wrote:
> > > > On Fri, Jul 10, 2026 at 11:07:40AM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Jul 10, 2026 at 09:57:05AM +0800, Inochi Amaoto wrote:
> > > > > > On Thu, Jul 09, 2026 at 10:16:28AM +0300, Andy Shevchenko wrote:
> > > > > > > On Thu, Jul 09, 2026 at 12:00:22PM +0800, Inochi Amaoto wrote:
> 
> ...
> 
> > > Then the counted_by will be incorrect as it may access valid memory, but
> > > unused by the driver.
> > 
> > After some search I found a requirement in GCC patch:
> > https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html
> > 
> > It seems like the array can have more elements than the counter.
> > Some I guess the reallocation is not necessary and the counter
> > is still correct. Correct me if I am wrong.
> 
> There will be no problem from memory accesses point of view, but there are two
> disadvantages:
> - the waste of memory for unused items
> - the memory accesses beyond used items, which may lead to or show the subtle
>   issues in the code elsewhere
> 
> Better to be correct. It might help debugging as well in some other cases.
> 
For correct number, I guess using "fwnode_property_get_reference_args"
is a idea, it is kind of ugly, but it does provide some function for
use to get the phy numbers. It is more like "of_clk_get_parent_count"
and "reset_control_get_count" in the clk/reset subsystems. 

I think adding a function like the above one is a good start point for
the phy array/bulk. At least this phy function is implementable for me,
since it is quite simple and straightforward.

Regards,
Inochi

> ...
> 
> > > > > > > > +	for (i = 0; i < k1->phy_count; i++)
> > > > > > > 
> > > > > > > 	for (unsigned int i = 0; i < k1->phy_count; i++)
> > > > > > 
> > > > > > I agree with the unsigned int, but I guess this definition is not
> > > > > > allowed in linux.
> > > > > 
> > > > > It's allowed and it's encouraged even by Linus. As long as iterator is local,
> > > > > use this syntax sugar and reduce its scope. It hardens the code.
> > > > 
> > > > Could you give me a reference url to check,
> > > 
> > > Sure, there are two (one for integers and one for pointers)
> > > https://lore.kernel.org/lkml/CAHk-=wiCOTW5UftUrAnvJkr6769D29tF7Of79gUjdQHS_TkF5A@mail.gmail.com/
> > > https://lore.kernel.org/lkml/CAHk-=wgy8p4is8ApEQCT5NS7XFb+NXeo-TKz7jRRZVksLLBSrQ@mail.gmail.com/
> > > 
> > > > I have not found this on the coding-style.
> > > > https://www.kernel.org/doc/html/latest/process/coding-style.html
> > > 
> > > Feel free to update the documentation.
> > 
> > Good to know thanks.
> 
> Are you going to update documentation? I can review it.
> 
> > > > > > > > +		phy_exit(k1->phy[i]);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
