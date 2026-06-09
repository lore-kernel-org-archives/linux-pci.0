Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46DE40E8C7;
	Tue,  9 Jun 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012952; cv=none; b=qpVvAwcmq80uvyiyugs5ugRiKS1poziLaeYuRnr3reDw3ToSvbweLMCaxdnbym5e0hKXGhrYRsclbqg+m+zpcJC4/xhOyKxEf0AlbTYHv8Y5VQZOVPE9PTRkA6yhUDBLs+gbLuOJV+X72njzhoqtxUbcbZj7Mu22BhQT/adxi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012952; c=relaxed/simple;
	bh=WxhbOuYpSpl2yIgiwi47dLiZKa3zfckbRSDuDArJltY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPhIsT8ptBGZj+eu6PeM5+GKrcb+f14WctTwFF+ILHMN1Y/IVFjU20saw3dH/u5p2Np6dmlKj3p4FVYUSOCPbAHYMe0plrQh/1GFiR85uSV8Gvs2G8k5vKyEuEJOl/hOw3BJyGuil+8rlKalPv0h95uN8q5GBMaV0dEaByd+fQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyTmZLyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyTmZLyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B167C1F00893;
	Tue,  9 Jun 2026 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781012951;
	bh=r1PpNnXqSXTs5AG7a3Ih5AzsgeYqEDZ57mDn3+pt+vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lyTmZLyCmkzp0SyC5AqZXteJeNIkS5cMPETrk5My54n7eNDVJTz2fRG6OrllQLjtd
	 mdNE47TUwi2JOfqDEOChBopdPu4YXRO7cA7yJ5gRpszpcmlYx80kXHR5frG4RY3N2p
	 R2TVsGMmscrJkGInSF6qEMLada2fvqplcP1GRiNO7WobNio2ojywvpkXS3UJ+eOiGx
	 T5g3z3DaYa/cZ01CUb430QlZYfKHZzjC4yfVYyeewNrnu52LwtyInqIvcGeNzrBOAf
	 u0EpwYwCVKjZwCAar84o/CXeeZAPqE3FANeux5NdIOJesPsiwv17xSSivU1kd93pi9
	 gmrJ3Ja/6LivQ==
Date: Tue, 9 Jun 2026 19:19:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBQ?=
 =?utf-8?B?Q0k6?= mediatek: Fix operator precedence in PCIE_FTS_NUM_L0 macro
Message-ID: <5l42fslp5jlkgi7xg56wd24xydte743zwijjue4qpbxfrtwzhn@t5f237jeplvk>
References: <20260515005552.2343-1-lirongqing@baidu.com>
 <20260515013659.DC03BC2BCC7@smtp.kernel.org>
 <953a48ccc3a94a29887a8059edc21a2a@baidu.com>
 <3994196b-b86d-9b88-b1da-6522d245d1c8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3994196b-b86d-9b88-b1da-6522d245d1c8@linux.intel.com>

On Mon, May 18, 2026 at 07:34:39PM +0300, Ilpo Järvinen wrote:
> On Mon, 18 May 2026, Li,Rongqing(ACG CCN) wrote:
> 
> > 
> > > 
> > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s)
> > > to consider:
> > > - [High] Fixing the macro changes the configured FTS number from 0 to 80,
> > > conflicting with the comment requiring 250 and potentially breaking L0s link
> > > recovery.
> > 
> > This requires confirmation from MediaTek
> > 
> > 
> > > - [Low] Missing explicit inclusion of `<linux/bitfield.h>` for `FIELD_PREP()`.
> > 
> > This isn't an issue. The current file includes ../pci.h, and ../pci.h 
> > includes linux/bitfield.h 
> 
> While likely true on surface, nothing in pci.h is fundamendally such that 
> it would require bitfield.h.
> 
> The include is there because of some static inline functions but lets say 
> somebody want's to refactor those functions into some .c file if the 
> function logic gets too complicated (infact, both are quite complicated 
> as is!) and remove the bitfield.h include. At that point, indirect include 
> chains are making the post refactoring cleanup harder.
> 
> That's why it's better to include what you use in each file.
> 

I completely agree with the IWYU (Include what you use) principle. So included
the bitfields header while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
