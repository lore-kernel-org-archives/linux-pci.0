Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C7374182
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927149; cv=none; b=rcOeovYopIumFLhzPtgcWZn6F9d1upzWH7IQmlMnPG/dqgVWZY1IuwSW62RH5MAGGhPpMUjb2esWS4uM/Yp71+4U55Av/nOmdGU02jSMg2Hhk4JO4L0KDFJdXrMu6OxRFdWOeZByvO6AOUG/p62O2FlMLpofzChNKhgSLfT2w+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927149; c=relaxed/simple;
	bh=cYr0xUn2xpNr3LTiRgwKnDqbAR7IqxyWqSNGui5urxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMpoxPqEdysNBkgwYCNpQoB7KTTG0q+ZIoci5US9yRWIKjd1zowe5i01nveTdRabeWu2Z7tzCCM10UBBkiqifiV6KcfOeXc4+0zdsOWW4nZSIe399mgbHFGqdxfWIDVi5LVvvYtHqzmR7LE1Am20bd8eYDQWwr/Y5a6wawFrGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCUyw9Al; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCUyw9Al"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so17245ad.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771927145; x=1772531945; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eblwuyUmTR+DmwKKXt5BlH8l1BOeREzivs7XkohPLYU=;
        b=uCUyw9AlNwbRuefdrpUdTPOvI0KUShaOZjAi7J5omIczWc8043+ENP0tCQNs1txptr
         y2SwDWgW1a+2ql/GvKM+vPj67HhE7FwMXWzdDL0iPK61tIQE2j0ecqhKy/2nigz6bifF
         1jG3mGs365+IfLNiqm26WlB45gmRxGnMOMksatYvwkc1g3gJLti1Zh9t01CuilIFwbll
         1TgM61cfNydIcqELmjZlSSyNol8WsKYCT58Uik8kxkR2a68cq8hsrQGEqT1Svp7yhmzc
         jDDsPJlX7gu+BssVVgHwqU0DGqQ9FvlhZz29o0ii1/ZxY7ZMUU9XapbwWY76J1slcqGQ
         iL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771927145; x=1772531945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eblwuyUmTR+DmwKKXt5BlH8l1BOeREzivs7XkohPLYU=;
        b=svN9xxouUQG8O/s2SJqDT9oWj3OW/7FToXP/LtacDihcbn5Fdr3tj8ppc39BqiRLzi
         RMF6ArPxMOeAi354+08K2MjnxP7gix4o5NIrX2ImTu1rnQtIQRa+1jfHs+V9EMXGNJUW
         AqZJvoGWbuRQDukvqXLtQTuSvggn3a2o8pIWU+PaMx3FaaFW0nDgLfeMQ+lKjgOxAJMk
         zVWfzmFaCB4xHAAnzksOGnf9v8v1nNyd4Hhvrs+QyW5W8+0D5e/MKO5NJnzNocapVEu+
         i/Rc6QOQJoTSJ3AOjZqlcqK+M9octOLjatOevTb60zEu8u0sv2jHnnuCCoTg6r6AbBRp
         kazw==
X-Forwarded-Encrypted: i=1; AJvYcCX4sH4m4wAQGViSE/D9F/4IdpviOOP1uyAd+FoAJCExLsiFpH2h2KSKY8YtwIns8Zl1nr7AljsajcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTFDfj6Dgp65boMyknbPoaEOIpWX/bJiyD9xjNxyaWTzdOggqh
	LnJHnqvWUwpQ2VFGnmRZe7ETB3l7aEPGRzdGJpNZlkM+GzmLzh3oJjmEtyMqliHZmA==
X-Gm-Gg: ATEYQzzqvVyEEwU89eidTCKffy2EzFb8XSTDsTVLIj5je32HOSA9F7xJVjeNIRL/5xT
	Aqg0nxrwFg/VU811tLLUGF/4O+iFrV6tPy8aVKMdAX17Rqe751oaf7B1ZDbbajmXFDsFjnyGNaK
	cjH7VY3F6jSf60LbJFrE8l8RGfM3FS/3ubdfGnT2e3hhDsW+llEQkINznLrulrZ9WVRt3SoDmNS
	/LtbQDtNq0ntxPGkFpqw6KXZBK8zqv7eBd8B76RnWpn/AK8UXu+u3VmQ14//B6gyp5CTT81K50r
	IJzq800dMzzXRkN8+DDIvKhT2YtG6VcC+qi8W18pjcCgam4KQlVNtLt43auxpOY2I4LN5oEb8EA
	eVpNWY4/Kygy96s2GUc3p8inwY4NaDbpoAKjq0hQ0WYWxfNljtVTnG/I/xWR+4qaHSM4tjpxquS
	Rc6Eswdx0iFcGiaoANOR9A9Qzs37kp7YQM3RlFCWPCc1Q7fQkfDcf+G8Mc4zGcwwHwxynVmnA=
X-Received: by 2002:a17:902:ec89:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2ada3497c30mr1333915ad.19.1771927145136;
        Tue, 24 Feb 2026 01:59:05 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd47c737sm9949341b3a.0.2026.02.24.01.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:59:04 -0800 (PST)
Date: Tue, 24 Feb 2026 09:58:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: "Yanjun.Zhu" <yanjun.zhu@linux.dev>, Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <aZ12X3tGn3W7YP4I@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
 <6dc423bd-36e6-4f97-b2b2-c7030575a3a1@linux.dev>
 <aYZ15u120FEa8Qw2@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYZ15u120FEa8Qw2@google.com>

On Fri, Feb 06, 2026 at 11:14:46PM +0000, David Matlack wrote:
> On 2026-02-06 02:37 PM, Yanjun.Zhu wrote:
> > On 1/29/26 1:24 PM, David Matlack wrote:
> 
> > > +int __init vfio_pci_liveupdate_init(void)
> > > +{
> > > +	if (!liveupdate_enabled())
> > > +		return 0;
> > 813 int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> > 814 {
> > 815         struct liveupdate_file_handler *fh_iter;
> > 816         int err;
> > 817
> > 818         if (!liveupdate_enabled())
> > 
> > 819                 return -EOPNOTSUPP;
> > 
> > In the function liveupdate_register_file_handler, liveupdate_enabled is also checked.
> > as such, it is not necessary to check here?
> 
> Yeah that is a bit odd. I see that memfd_luo_init() just checks for
> -EOPNOTSUPP. We can do the same thing here.

If we move to checking the return value for -EOPNOTSUPP, we should
ensure the pattern is consistent for the upcoming PCI registration in
Patch 7 as well. With this addressed:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
