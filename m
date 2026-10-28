Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209470;
	b=sc6fgg4DS0G6mRVc8k//tInKfg8VBq1cP0VQ0kgAu2Ypq+572ab7d9GQB/dLAL6gFgiJ
	 vvY3ekVFJA9Jz9QPzDJad2HIWb64qc7v+SXQM3HB57wp3YAaXeHT5mw7ZWkUZQV/ghz9q
	 y7pExRc/8DcVyPNhm3Of0mrZ7dcKBdXeTzh4EGbLqecJiu6shYtRBu1QO6bJJzWw/1RfE
	 6jGY1JRV8+90DtPOcGX1EWFOKN0SVpfO6L4pMnAWOh9XVzT3afjVcPd1p9uJf4bmBVths
	 d7KPkqb3SRoMTcqFyTqGYlR5HNGIlVuJgUwNbZCC04WDcFQbF73VOu/PjIVExr28bvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=s56cw49H74YOeay3n+CLmJxr96H3PjfrjsaPdtr6E80=;
	b=Nd38s8w5CKunKbPwfxAY3W7eo6BTl7sADHZJGKnM+Ho05F6I9GCHTH1YJFAonPM55LM0
	 mmGvmgBeQlkp0I/KOhrb1n/GxuiHdBm+opftuxeXOMyJzZnU3At1/9aviMH++j2I7a6fT
	 0A95VurD5V+3x0ySwx07mHjXhf6s1WUPiVbJS6ks9sWbx+81SOQDCpmTqIIzSTQsTVdUz
	 get5v8ma+Z07qBHwewQJTxPDhrAuOLHIokqTmBn1UKCIo48vux2Ue7kwrRY9Rlx++mBzW
	 B35+37r4+yeM4yMDL8/ppsht2FLtKO86+RkFsTCSU2S4+B5TEdjbYfImytE30+d3tQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=iJy5kuJI;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DD8606A324
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 17:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79DD8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=iJy5kuJI
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc81984fceso396498137.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793209469; x=1793814269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s56cw49H74YOeay3n+CLmJxr96H3PjfrjsaPdtr6E80=;
        b=iJy5kuJIKEFoVGXIv0G1W+lcBvi4+8Xg3Up72eyRWsM34ppCddP5ilpekezxnMXx54
         wNVtglNWl1Juw56jX8SNwQS7WZKs9Y2X61a375wMFfYgiH4i03Atn7I+ij8S+kLhqtfT
         l07FNZinyoqAk6s+eVtDRNFkKCg8ONt5X560obpxpG2ZC7VnPvjzuP7bhaeVMMRQaZQf
         bnvIZGVN+qVBNlncKqiFZBQ2j+79seozjiyPSZgLY1TuGDnPTDoB10ATDbxfyjixqlJz
         vdOfv2Qybh76j3dxSW1ILlTknOlei2s6oL7+i6Y7LDLEJWeTZKkbkP+obWZ+cP33y8/P
         9s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209469; x=1793814269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s56cw49H74YOeay3n+CLmJxr96H3PjfrjsaPdtr6E80=;
        b=CRArUd6zJbIbG7X1th8b4i3DoCh+gz+VMQylLSOU52FCeEJsJax8Z0w3XHWc9klUMK
         hknOJ6XGXBmRRxBGZgefsIE/GtIX95D2h4jXHo30XJ5ykbj1wkHT1U7NXWH/vRxe3+gz
         odDpZ1ySV5QZQfueVl85283UZySBdegtxUftbGfV2GjQJzcOG7e9HqT8fogClDrJ4lzK
         CoNP7s8oJdqi+MTByosxzSaNwhYO5RYoHnJ05MVVbivQVrr51aJRsuRgVBvZhasnxkVI
         KFjPaUSHIcA7a/7nFes6tio+V/XAV90zkDWX0YOp4LxCBgvCgPwm8RHgUfmzK8xN9DDt
         jEXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwe8Tplj3GIulueGf2eo9KnlnkGUCs0Bo8Yk6ukL3eKlxS+mu1h30zu5/VJYUpRy4wERjwz4yNEyPQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjH4dhgAz8b+xo/Z67mVEQR+G4HQQBNLkzkk8lQ4Yir7GeagXW
	auo3yfep4zSO4EwsFRUUbbcOyHCS/CYywuyqWrEFIwDgsFDpl1xDs/AGGqvlh0hnFU4=
X-Gm-Gg: AYBFou2amekWd1ToS0noS2dBwV8vqlPuAaUNCfi5RvuPGdl7eXBWAq6q8BT3MCQbq4g
	YQrzwGtVl531zdCWfRVmk9uhD6tvOZ7gaS4Z3cPCLarQW1DmLbJMsNIfIQtVo70Xjexknshswor
	pmd8zc/rRhPaAVJFnDoxXZrvJjRh9drAQ/SLhY6hB9dr2CcNuR3YAO0WtlJX101oJ8yj3oHW3E1
	fXxt3SNN+PhFn/ZLtR/qjvG6iQHMdtm9gKewL8HqgfoctgJSLexIwbhCytE3dGAZCufeEyje1/p
	l5je1+vFqTqJ4i8b2+p63eWYjuYVB8XCX9Xpk5fslL3wOn+DYf4rPfoLK38xbjN7ktbJIuwUJ9g
	38gvPxEtCU9Tt+7Aj717hzPcuSA3TOX4FISXStaa9xUEfcIi7qvYxcsHAc94WfTvawwYwVJNtMg
	+02Qlc2LVFQaPLaPXEuXWGZGXLsk/cRi3LLCk95oycfA/AsL85JMo9qikNsfkgDXUOvpTY/mmTM
	dIMSFLqLidygi8Oby/P9NoW9jQmmK5wDjBh7w2DVj6nVyUPQl3sbqBsiHKdB6JqAZiyrM+/M1qL
	ccxbUZhmOjSECLjtUzqbpvM+17FVyWicj/RGoy+trbiOPgBeN9Y8dwDlzgCjcaLtNLfv3N5SN5u
	16V10cZkyUgntDwLBbdtuNrYeKQMuzDQz
X-Received: by 2002:a05:6102:3e8d:b0:7a5:7282:1994 with SMTP id ada2fe7eead31-7d03a50a85cmr1269510137.7.1793209468986;
        Wed, 28 Oct 2026 10:44:28 -0700 (PDT)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99125931983sm6616412241.2.2026.10.28.10.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:44:28 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:44:27 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, 
	seanjc@google.com, will@kernel.org, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auIvjVmWnsVPN_9g@google.com>
References: <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
 <2vxz8q3hoicx.fsf@kernel.org>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxz8q3hoicx.fsf@kernel.org>

On 10-28 18:17, Pratyush Yadav wrote:
> On Mon, Oct 26 2026, David Matlack wrote:
> 
> > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> >> On Fri, Oct 23, 2026 at 9:50 AM David Matlack <dmatlack@google.com> wrote:
> >
> [...]
> >> The reason I care about keeping the header compact is that we are
> >> defining a foundational kernel ABI and want to use this header across
> >> almost every serialized data structure so we can evolve them later
> >> without breaking compatibility. While some top-level structs are on
> >> sparse folios today, other serialized structs are tightly packed, and
> >> we are looking to add KHO slab support in the future where tightly
> >> packed allocations will be common.
> >
> > My intuition is we will have a small number of headers per preserved
> > file and per preserved FLB. One for the top-level struct and then
> > optionally a few more for sub-structs like arch-specific data. That is
> > why I am less worried 8 bytes per header, even if we fix the folio
> > problem.
> >
> > Maybe where our visions differ is when there are collections of
> > serialized structs, like KHO blocks. For collections I don't think the
> > elements will each have their own headers. Otherwise the elements could
> > be different sizes.
> 
> kho_block today doesn't store entry_size in the serialized payload. It
> relies on its caller to do so. With extensible structures, this can get
> messy. Sure, the owner of the kho_block_set can track the size somewhere
> in its payload, but perhaps we should store the size in
> kho_block_header_ser to begin with?

I agree, and we will discuss versioned vs. owned serialized data 
structures separately. With this series, we establish a common 
framework: size/feature flags and accessors, and we update most of our 
serialized structs to include them. All "shared" structs (e.g., KHO, 
FLB, radix-tree, block_sets, etc.) should have their own versioning.

kho_block_header_ser should have this header. 

Pasha

> 
> Anyway, not a problem this series needs to solve, but something we
> should eventually do.
> 
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav
