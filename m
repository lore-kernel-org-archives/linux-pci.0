Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526276;
	b=x2T4igU7IxQnrDDt5rsyLXo5S4zWEADrta9tZID8fmto5ZslEbdSl3GvHCKlvYXMzLYP
	 nPGabMWpvDdXJtfDJrrROj7phVnVs9dypwJmcqJV/0eIGfY1sv2aSUZH150pcfEtYlVJZ
	 i8uFeUgap592kzVRLOlT5aEkphpJ+zKmNfPQqDTewUjxCpzv1KrO949fpWSex76fv0+oC
	 p3qaZXeeZe+GzDJ6tEnGlVQsLzK9Dh3vrBm/rU3dj4kVnjBb6Nf9BjNibNC+R53/L5QOI
	 VVUj2yyoA02TzXzCMY5aWyoWH1PBLZKsMLqE8Xu6wQ7uYRpqQb0NYjWNoQ9tTdspBkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=JQr5O3TAm0LrUQZ23OaV0ywjiZMgF6OfZ39GqtSUwII=;
	b=Lcp0KNRbXgx52R7ub+R0XKRQnDYcBNzV6fHqdb2nmOGywlwL+q+fu23sx5c07zgfRQU/
	 6JEeFMj2+kEMyz1OYNiWIVlueKhG0WJLW5Am4KkhUpoZ+HgAmFGA/54yWmPAbxtFEQJ7Y
	 wleGQ08NPUGOq6bS/ftr8WBhqSjFKw89TKTiI9tOHCJ94Zm2ba3vSfUa20Ag7/q8LFdDm
	 sR48QBMECOH2CMKi1sx1ucaCkIdwgZ915h6rEiuPtg16rJn21H/0xSDMNLnPONS8SAGjP
	 4CfItpOnYMzq2wAaaqFnXPW4Fgaq4wOaqJDbT38wPvTU6kVHQxwnNHeKUr+xXDH3sGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XAywAbuF;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E0606A326
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 13:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 519E0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XAywAbuF
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5366ae57896so46637821cf.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 05:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795526275; x=1796131075; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQr5O3TAm0LrUQZ23OaV0ywjiZMgF6OfZ39GqtSUwII=;
        b=XAywAbuFEHdpJgqLJx+wUsQ2Y9xv2xvwJ8cx1D23A/19ETslrZoMGfHL0NL/0BPOdN
         r35Qf6xmAzDpVaLAQdRrQsiMPSqsetc+ml2RXu3vOohu6QDkZUP+Atb7gRh6ylyZ//eS
         /UgL4bwWZfuimVGs93FM+9yw2B8f91282LVGstj1T94xz5p49EHvC75ggBq4CyfH9rJ6
         XnWXrnxMTxgXAWrYGsXDArNzsIJ5Avgu8co/TZiboocNSH1hG0IWgNkW+Qm0nAiMc0O2
         ItAtoxIwIy9fbWjC5UOnUFshs0r4UjZpkp0xioG9e6uuGS0fzR3JkIEj3coXzHd7brvE
         hF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526275; x=1796131075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JQr5O3TAm0LrUQZ23OaV0ywjiZMgF6OfZ39GqtSUwII=;
        b=WqMhxGyTzJxXYdQtmLRCL21Q2mu3F0AS3RZ7e5DIOlapfVSgN5HlgZdHirRJP24UyB
         S9naYee07A2TZq9W/ptipNKNbyLI9TvbQpfDi6BtYE8oAlr4FeJbqZqdLEDVhSETAEZL
         vaj4T6+tLS7sqmibjg6xXXNOhdfThdZxhp7JsEXK9XaPR9AtpDd8WAlNyKxKZ1HWbR3k
         NnHwVHM87LHx1cvhXt/4uC67Y8nqt1QhUkPFtCXushreKkWDIaPl533m39QWpliFBsv2
         zWxJpLtEFkPsZdCzxreOneUPvhZ+2JWSJWIHM86J8A7EpU5BDUNrXcur50fVqjlg0mWY
         /UUQ==
X-Forwarded-Encrypted: i=1; AL+hErEWurzO/KeqV1ka6YvZs9kXDvCG4p11Q/ATXTkuCzH0UbooPZzi87slzIkmeyKyKbg9TIEXhr8DEYE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SlEDqB2bsx5cFRoTZ0NlqYQWAVEFPMuMZQvTU7iNCtO3QVeSz
	QPPnFwsTcHPecxbqTagWl/3e6K101x8o8YkqqKR40KMNdw3iDDVK0Qf3QX8HtEPmtgE=
X-Gm-Gg: AZFdTZfBxi9JcF4SW26gR7VTVsf0ayDElpw0lywJbX3x4WOlAW3qsigZCkdr4hzZ0+R
	U7wCEk/RALrzXP4V9G2PhduunBdUwrEickPglCq9czE2PQwcjQgo4/qE4Rs40Ir1bMMCuuAJEQL
	ZW7jg/4DfrjT6YzNUiZFjPufWUTNWk9vjoeP0ObQXrXMS3AvZRJe/+I4LVSKBet/mnMqMNzMVXJ
	b64muSWhr3MVQK6Tzc/HxHvycrKnnyklzgRB6kvu8pslWWgJlkcxinzGLoJAe2PfnbI1iJI3Gpa
	nF23tliey+S61fSc6ftwypt/fIuol4lpYvasDtGrq5mBoQWqHfxl55iuq5aYvCwN+25jxoUz+hQ
	yQhnKehWNAgRKvM4yPzfpz0x6AWVrzj/JwIjy64MY3kZ9bGtCdu6bYR3rpKQ/+mz6Eyul/NSxgz
	k8U0lJMKixkQv4HIzXYn6KqJcFnfhy4jiHiIAt3nrKLQBEeaayNRmL/Eef4T6T5vr+Bk/Q8hSw+
	U/MY0IqcXtfXlpNvGpqb+15ko6lnawUxwZqKTr6rD+zZz0Y25QRyZdFbNCQ8UnoyFSd/oSELZi3
	85kem+c=
X-Received: by 2002:a05:620a:3722:b0:949:472f:226e with SMTP id af79cd13be357-949bab15455mr2786066785a.71.1795526275080;
        Tue, 24 Nov 2026 05:17:55 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cdfbasm134605646d6.17.2026.11.24.05.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:17:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVqPC-00000000P5z-0Ouc;
	Tue, 24 Nov 2026 09:17:54 -0400
Date: Tue, 24 Nov 2026 09:17:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 00/10] PCI/TSM: Support guest TSM drivers
Message-ID: <20261124131754.GF9566@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <2026112325-emit-squeezing-5d96@gregkh>
 <20261123090623.GK14811@unreal>
 <yq5a7bi3riha.fsf@kernel.org>
 <20261123115803.GN14811@unreal>
 <yq5awlq3pto0.fsf@kernel.org>
 <20261123135638.GO14811@unreal>
 <20261123152533.GE179082@ziepe.ca>
 <20261123185826.GP14811@unreal>
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
In-Reply-To: <20261123185826.GP14811@unreal>

On Mon, Nov 23, 2026 at 08:58:26PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 23, 2026 at 11:25:33AM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 23, 2026 at 03:56:38PM +0200, Leon Romanovsky wrote:
> > > > >> >> But it should not, as you are making driver core changes that will
> > > > >> >> mirror the same thing that that patchset is attempting to do.  Please
> > > > >> >> work together on this.
> > > > >> >
> > > > >> > +10000000,
> > > > >> >
> > > > >> > Greg,
> > > > >> >
> > > > >> > This series came as a surprise to me given the fact that device trust
> > > > >> > series is exactly for that - allow confidential computing.
> > 
> > Device trust's primary role in enabling confidential computing is to
> > give space for the userspace to do all the TSM and attestation stuff
> > to get the device into T=1 private DMA mode.
> 
> <...>
> 
> > Getting the device into T=1 should influence how the userspace decides
> > to set the trust level, but it doesn't interact inside the kernel.
> 
> The point is that I’m describing the reverse relationship: the trust
> level should determine how the device is configured, not the other
> way around, as you suggest.

They are unrelated. Neither influences the other. The user gets to
make orthogonal choices if they want T=1 DMA and if they want
adverserial. All combinations are useful and valid.

Jason
