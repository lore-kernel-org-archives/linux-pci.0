Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488525;
	b=LU8qU/6ie+FRzqJqTIfYe2cpeKTGinlKfSRq1ivUWfI5poCd79EAT4+DSLCeEa+hLHgM
	 ZRsVZ2aYyUuHQCNvlfP4iVUNsHtiCQxcwT1XH/CexHIxiHecLR1VWOiPMO9kZSP8NiS79
	 /pCGpHNqDaPunCwLLJcxCEZyMLXgqk/TpZ4GxTC5NUt0+YTK9Xtb7mMz5iVgpj5dynOb9
	 RRp8+RxPyboXLNBOq6mlePyI9GT8EG90I9ekjypQcMKy7T2L9PVzzwofp0MeEzfNOIV7E
	 Fz/lNPjuqVsvjfFk79R8Lyn/ZI4KiSWLK2nyw1Ozi7TZnfygrxgAiCcsUZse53DQkpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=feBMC46Kg9xglm0UM1RjR22Aujb6Qvmmma1ih7AmJ8A=;
	b=HNOrJxJNB2s0p+oOrCgDuLrIR/UYHUY6B7N8YsEEB+T0OxDfy3ANhEmPRyvbgqzLEx1C
	 m+7R7ABryHGtmFnrleb39Rr9thk0/cboyJ+j8UvfRIK7e8t13xfYYr3BmQWj0bI9zXhwI
	 J7/OFvXRtve7rrzR8iJcZ/7PBlWrguRBF+lgWSNTpAAV+JxC4jlAyxfaSHwKw7+rWwmVj
	 TRy0MH0R8EHRq6WoqJL+x7diMXyfgcKJyg5xDd1uzqqHc7hYhcPdb1YKBAIk78kgj9vq8
	 DsSzokB7BNSl3ai1yFC7mWKSmzu7gCygxkmAcM/9xycXXQ09OoYrz3ITQqH/ElB2Gqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ODvelHFE;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D05606A326
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 02:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D05606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ODvelHFE
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-92106d5371dso51287316d6.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 18:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795488524; x=1796093324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=feBMC46Kg9xglm0UM1RjR22Aujb6Qvmmma1ih7AmJ8A=;
        b=ODvelHFEv1H1fitxrY3MRiNYEMBDVg1At/2gXLR6bhj9RFU2tjIZnEOzaHw/otk14D
         yyO1CPZzlSsmxohkC1xnXGxUIKf2lDLUBFvIxHY9sPBAx0oEyt7QkMssB/M71zL8n7wD
         bBu1pQ3KBa6QY0t4ZwLyAZCUw+VdLDrJ6Ismt2uw0+Gay7FKNuzEUF0VcVHt5llkx19k
         KF5mQSjSSQDRODHfBRv2m/22MQ2JFbEsKyTPkn2vzj/t8eIWG1Rf35Lall1BRQpoXbbZ
         ucrMRWQhY9+oxccmra8UzAHd65tSqZKE27/QzoMVM0Jhcw/epWxAj5RxUEtIV2hkPNf1
         yAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795488524; x=1796093324;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=feBMC46Kg9xglm0UM1RjR22Aujb6Qvmmma1ih7AmJ8A=;
        b=lefY/tP/ki0YfI68qUREyZig3tFobU/9kLMFwbE7E1k4/AkW9LFBGrutRrytl0c2R0
         sYO78YSwj/oHQoj348KM3GKV9poc6gr6baacpNUHXjQOEVjUReHbFkrmXZtnKucYLneD
         FZiAKx48FaY5gF1KdAm4Il9WfyDJ9HZRJ7LS0A40nVXi9B3P1gjEfS9yPKNgeg0cZLJe
         cvZJq+UMXwDqEVBE6qQD4ZBRECWxfEog2xGR69IH5b89TvIJNzs3tgsgirO7/iGv7q3v
         3AjsePGFDW0MYHCYIyscV/IDh5IWJ8he5OsXW3IGd/zB6VimntaeE6plJnEtY5XDGjqx
         iqkw==
X-Forwarded-Encrypted: i=1; AL+hErEhXdgL6H73RPwq90v0/cuV2N+izHTMYe7HOLYSWJ7PPOx0Zd9rTe5GTJtgKmiLyKugumEhkK4OBTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0nmpYGGyedRnXebw03FDasvZBC8uUdO1SUJzstHUPigrItmJf
	4wdmL0JfhTk4kkauHPJ+fpfPEqwT6L83J+USh2JrpMiAWcOj96LqdLlq+Xfpda+XxaM=
X-Gm-Gg: AZFdTZczaip9PLmGe6qI5Pc2QTuGLbDokw+BcnjioboPbB7PMqY/7K4olcFjsFZPcZs
	wL8ZrmjuhyMPRiJTct0emez2iEL5E7lVXeFKNK5DxKLFfTo1TMrlY19lsMiW0egoh3Qc0HhqU2k
	2Ndc6fR+RSYxGpMgxgC2pnOeHHGjnz7LzGqISIrhJ0ww0iwh1fJ8dtU6CMZ97ctkuaemmPeCkEV
	2KhxrMz4WuyvgXJl0Fs6tEhS85vTYIPfCWoBOLStkBiWHTGpqb5taqINTh2K9D3jcE9ZcUAs2Jo
	K6mxO21IKWm9ZBLQZ3hn2begLxd0qsquEab0acIuU9WwX8c8GlzaX01QIsirMAZmc3b3GiQjsM+
	TmxfrBTJOGNesBjqddtlUV2cpGj/nG89nI/hndxyiFksQ+O1AlFaZE/zIl/OqaY4MzwAtWKInwC
	YWZUF1ZPUlAxh5clBq6gI1wa1jq64XPB8zE1SVci5Esw5obAP50PzNByVYYGoeWpcvTq+fgc3fN
	di5qVEoIkCvINeDaQ4fVZ8Jr5AuG5uwBXhhXmmX2ZG1To0s8gWcANrAe4AUyYZiWdnraG2jhq2g
	9Xt+Ek4=
X-Received: by 2002:a05:6214:2263:b0:921:37ed:5c6 with SMTP id 6a1803df08f44-92137ed06efmr217313286d6.22.1795488523691;
        Mon, 23 Nov 2026 18:48:43 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm122581686d6.18.2026.11.23.18.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:48:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVgaI-000000002sY-302b;
	Mon, 23 Nov 2026 22:48:42 -0400
Date: Mon, 23 Nov 2026 22:48:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 01/10] PCI/TSM: Report active IDE streams per host
 bridge
Message-ID: <20261124024842.GB9566@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-2-aneesh.kumar@kernel.org>
 <f377271d-353f-4c8e-94d5-98159a66ab28@amd.com>
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
In-Reply-To: <f377271d-353f-4c8e-94d5-98159a66ab28@amd.com>

On Tue, Nov 24, 2026 at 11:11:49AM +1100, Alexey Kardashevskiy wrote:
> On 23/11/26 19:33, Aneesh Kumar K.V (Arm) wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > The first attempt at an ABI for this failed to account for naming
> > collisions across host bridges:
> > 
> > Commit a4438f06b1db ("PCI/TSM: Report active IDE streams")
> > 
> > Revive this ABI with a per host bridge link that appears at first stream
> > creation for a given host bridge and disappears after the last stream is
> > removed.
> > 
> > For systems with many host bridge objects it allows:
> > 
> >      ls /sys/class/tsm/tsmN/pci*/stream*
> > 
> > ...to find all the host bridges with active streams without first iterating
> > over all host bridges. Yilun notes that is handy to have this short cut [1]
> > and from an administrator perspective it helps with inventory for
> > constrained stream resources.
> > 
> > Link: http://lore.kernel.org/aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050 [1]
> > Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > ---
> >   Documentation/ABI/testing/sysfs-class-tsm | 13 ++++
> >   drivers/pci/ide.c                         |  4 +
> >   drivers/virt/coco/tsm-core.c              | 95 +++++++++++++++++++++++
> 
> I'll take to the tsm tree, thanks!

Lets not take any new sysfs APIs please. These all need a careful
thing and we are not having a good history right now on any of these.

I'm not even sure what this is supposed to be for, is it debugging?

Jason
