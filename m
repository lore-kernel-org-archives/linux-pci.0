Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13B4A49A5
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361295; cv=none; b=Mx+q82ppMXqEW537OlMZQVOfg4k2JHsXR5AoGG8RGPLuxpmx7fxTLsYW/QQAMP3yurZM80UP4lUWvpHMZoZDBTcTd330dFVyDLoLTjGD6Idj0u7nwBAxqyJuYQj4L/nnRYVy0ashcuXcVwvrGu4y5vPFDXkvC3Gsfi1JDVTMimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361295; c=relaxed/simple;
	bh=vyI0+5T8UYK55sjN7c+Akwn7k1qbx8c77K/++T6sd1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkofXubTxY5MgE6lqEf22IDPHzF3Z2AVT8c/0YViEpTmGTh3O86T4DjAZcLCwJLbVJrYnC6oVMOTxUg/zawNdALw5sIJuAtslFVlLHOoFnCJX5tNDyZTILT5kHDxWcvw9+VWqd56iPAUzwub4aTwgRK0oD9dMoGHW7BPCUpWUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LDYUV4yu; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LDYUV4yu"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-930c0f9c1b1so127731385a.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788361288; x=1788966088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=giebtW14WRSNN/oAZ2HvlFksj8A4SENo3e4Bwxaljok=;
        b=LDYUV4yuEtDJRMCMwaI/aKWDQAoVLE++IMs6T4Ss6v8LET3YKOmk9oObpVDN5ywC0N
         bFnDxvtzFR7JXk4VH3FpfQjzj/GRd0j2ifRA5451fsLmGwCT5QPMJ70aLLCfo8Xz8sco
         RAMT/uJiAsdLZVB65wNDYC6GSGRcDFDZ5Z9BfWkKYx3j/W4tTAm8CUORIDnBU9OQtzHv
         86syV5D+PsKhEhZWQNRgYgj1dB/L0tzCwpZ7Zp1Evdbw49O3CBUBFxqPeHpTfDGkgGR9
         imE2UWXu+IrdDItEydMBvTaTMMhqNy3tiitpJxT4d65m1zBiyWssT+uG22s7/pHbVpL1
         mFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361288; x=1788966088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=giebtW14WRSNN/oAZ2HvlFksj8A4SENo3e4Bwxaljok=;
        b=bBdSl9mwQba+OdKIqcvElpPtgP+0fartvnSeN2lanHg9O2H70pAmuaCl2eRnWFuCFi
         hIeV8CUktqXINGp07nm5Aoz4Dc8EvmXB8m5brYLMhh2PxbyULuw3r1AnAcMfSRtTE+wZ
         8pee1Vz6yYxlwxTc+Fb2cglUQ3r5LpkIZEEY119owXJRZQicG/BtZBXv3gig+7yPAcGp
         L5ijfl2+9I+H5DJRJDTWQI95CBbo10VPm2yJLzNJijkfFoJrUiIZiOmN/SCZUXSRpCL2
         ZwJMqS1py9p5QNpFHluyJJCQVLApI+FquaEF9ClGP6TsOk/avpcCUOQzObNAbY7fgyJj
         mGiQ==
X-Forwarded-Encrypted: i=1; AHgh+RofoEW8VxvoEaVNV35H0fE9K8FQccALbtLenVTmfSyU1JTc9UWaW9ZZiwL5Val/Hi1BrPo5vgwRmL8=@vger.kernel.org
X-Gm-Message-State: AFuF++kNlDv6fb0RywOoA4lrMnz0/xDPQYTFXsWWeiH4NyrUIi7XVIsk
	chHWvo08MEfmURd4c19V6XY279kZL/RDDBvHLpaTSPmbsE7ZFgszDqYfUeKMlI/pIPA=
X-Gm-Gg: AR+sD12HJ8nXyK8jgrFVsIHJ/q7C9b6nicG5MpjeJE71OJvpbjOJplXed4Yls8E5fMX
	XuYzV4hP5lHo0aTAOAXSOjuy3Te50uAD1vM0LTvxT8QajoYxq9Fo/iqj9rxoRuDwo1dFwwM+X5z
	yKrujJznv2dJFvnAnHKbDOZL2xPNOaSsSnzgX+/EGegBEXZZX6c/eVwIUFvxThlR7wYCq1CfdQR
	gGjZrKXtjIn81VKa8njBLuuK+MvF7qZrDRWnp/8c0lb+UxTk0qfmx6hdYRXcxYMPTHmz2QlGJ69
	Ruo70VWBYLKTUTA2OmvTEewbzUl/SVao5b/AhC07Fb7OgohFnedbhWiNbUMAov+ZO36ZXDb4Xd/
	jAo679KgiaVH4HZsnWywaQjiJA2CXCNKknTYKdLBBwyiqi+MzsaQMh28r3EHlCM6ort+y1VmpCH
	R39zGK2pUASaGElNsYcIccEjnsi/8qons+Y4b8HEV9HDUpTr3WCtYr8RMnvQAobbFE/WMfnjciS
	CnxCRgpyJGBbVleuNRwlptMh9tqpmxbPbIAHMmpxq/MBg==
X-Received: by 2002:a05:620a:178c:b0:937:372a:b97 with SMTP id af79cd13be357-93960dd7c34mr628429685a.17.1788361287651;
        Wed, 02 Sep 2026 08:01:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f157adesm227012985a.1.2026.09.02.08.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:01:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x1mSr-0000000EU0M-3Bwb;
	Wed, 02 Sep 2026 12:01:25 -0300
Date: Wed, 2 Sep 2026 12:01:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, ankita@nvidia.com,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev, Aaron Tomlin <atomlin@atomlin.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <20260902150125.GD2890729@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>

On Wed, Sep 02, 2026 at 12:20:51PM +1000, Alexey Kardashevskiy wrote:
> On 2/9/26 12:12, Xu Yilun wrote:
> > On Tue, Aug 04, 2026 at 09:55:33PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 04, 2026 at 09:48:30AM +0800, Xu Yilun wrote:
> > > 
> > > > Glad to see you all here to make progress! Intel can also help on this.
> > > > Can we have a meeting to discuss on these topics? As Alexey mentioned,
> > > > previously we had a bi-weekly call, perhaps use that for our first
> > > > meeting? Or what time works best for everyone?
> > > 
> > > I prefer we defer such community discussions till September, that
> > > seems appropriate given some dates I've seen.
> > 
> > Hi Ankit & Jason,
> > 
> > Do we have a plan to schedule a meeting to discuss next steps?
> > 
> > If so, we can figure out a specific time on the Discord channel.
> > https://discord.gg/KKqC438c

> So I've been trying to find a time slot. Say, keep it on Thursdays
> (USA) (kinda short notice), bi-weekly, we can do:

I've asked several people in Europe to help on parts of this series,
and combined with China/Aus someone is going to end up left out.

I know people are anxious about their projects. In the short term I
will volunteer to send patches (ie bug fixes!) to Linus in the CC area
Dan was responsible for. Please email me if something needs some
attention and we can figure it out.

To fully move forward we need to establish a new TSM maintainer
team. In my past experience a consensus has emerged off list, I
suggest we try that here as well. Several people should be
recruited. I will also volunteer to help train and launch a new team.

I can say that several people from NVIDIA are working on the ideas in
this patch series. Ankit is setting up a team to focus on upstream
patches for all of CC inside NVIDIA. I've asked Jiri Pirko to work on
the PCI evidence uAPI based on his deep netlink experience, and Leon
Romanovsky to work on the binding problem/adversarial/trust level
driver core idea. They will share their approaches for solving these
problems as seperate proposals.

> Scenario A:
> Seattle (PDT, UTC-7)		07:00 – 08:00	Day 1
> Atlantic Time (ADT, UTC-3)	11:00 – 12:00	Day 1
> Berlin (CEST, UTC+2)		16:00 – 17:00	Day 1
> India (IST, UTC+5:30)		19:30 – 20:30	Day 1
> China (CST, UTC+8)		22:00 – 23:00	Day 1
> Sydney (AEST, UTC+10)		00:00 – 01:00	Day 2 (I can do it once in 2 weeks)

This is the only time Europe could reasonably participate in,
obviously it is not OK for China and Aus.

> Please, comment. I find these calls pretty productive syncups. So
> far we were not having Europe in these calls.

Calls are undoutably useful!

> Alternatively, wait until the LPC in a month but I suspect not
> everybody is going to be there.
 
LPC is not that far away, I think we should have a goal of having a
consensus for or at LPC

Regards,
Jason
