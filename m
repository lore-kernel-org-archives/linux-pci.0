Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B3377AA7
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458019; cv=none; b=iwI3UgIPq2eyC1E3dyj/MH6FLTs4M6N+Uk8dsyxcRzM+a09kXdjjPdIUqvBs+UuN06qqoD2qCuBvdK0RxKbx7n8fABcoURC7cNZxHmX8ij7jKhelPS4hSB3xBKBPAt5iBC+SfYn8VQ6Ft4SzTaeWonOBnuHnqx4Di6sNEN76CZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458019; c=relaxed/simple;
	bh=DzQDxkkXEH2+Mp8OUsaYNxAH3LbRjRgBZk7gary7lQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWmQ50ecXvBWlS1KTmjCegGzEnBt9goQn0INexXjj8J8ZWTqYmVEfdgJQxaUTiJwOkgs3ysmuEbHk700LDEkuUcUp8YWk52gM4G+dFsXH/jhqnLkv4a/7YvAklSPsT2KXOrTC5TyaOt5Ui72QGyy18VosgENo+DqEL4QVHrypJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=isX65nms; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="isX65nms"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-530420edf1bso3176591cf.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788458015; x=1789062815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d4rOxY3h7ZQvpkIblsAFRKEuph26UmxGEHCOpw1rXj8=;
        b=isX65nms0T7vUHhbSbQeqESB+Pq1PGHkIu5hE3AUWKTO01Sp67VRzj5hYzmxCdTcWo
         6wPKKLeQF85vz4uIW+Ebyv1FwkI+W2gHG+LbLcEIYuMy4DQuQA/ulLxtHt/IbzA8E9hj
         fmaJmIGHQvFdAn74XT7yv0kpkCYq1um9ddDMVcQI29bRnmn4VadiNFIEuI9SNyTe6JCy
         qXIv2f7WGWcWiLdCSZ8o16hlnid7Pbf6nNNVCrhtRtgt5qZ6ZxrrwBzL5ZYP+F+j96EZ
         3lvGzTx5jwCmn2ZjL9TZGLl4cgTaofVIde7vd4Vxe0wvL90O/MiA4Q2C74VFt7jrBukk
         C4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458015; x=1789062815;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4rOxY3h7ZQvpkIblsAFRKEuph26UmxGEHCOpw1rXj8=;
        b=QQPaEWEuVuSuwdM1LbhLdGFkuVa8trj74ou+cd2e7Rlg82lLnuZbAS0BN542muwf0O
         jseYpIWKYva1UAfgKRIhpXbdS2CKXvyW36d7UWmo4wCD520KF9qWtvgl9NuZasPPqaN7
         iElN7ElfPy0YSC9fXBT0BcwsW5LQGP1xbTzsIDTH+KMoa4jWBC1C/raDaANxdk2NWfzu
         ZeDC3u1eH3ozTDGfrtHH5HQuvgaYmFmD0MV6XbAlqZNa4smNot8HRulEkh5BcYLY3R2c
         FV1iQ39nUF1a3Rvsnt2DMS+vzKRg/eeHUVacEo8HZrBfIkPTdj6bnsn13HZXbPtV/sKB
         pr0A==
X-Forwarded-Encrypted: i=1; AKwUvBw3TUCovxOmwD97Ahg1+DFsP5lYSzCf+ezPlrJonxf5ygq2bo2Fe12wmO2cptDvoS80qXAKJRwI+cI=@vger.kernel.org
X-Gm-Message-State: AFuF++n/uUFn9GKQrYj4fY4WCAmjujv6tH3YsbsOQCiaYVTilZMIaSPL
	cCNlU0eGSj1Rdlvf7FrvWfd0DdHqN4A4pS73OAq505Xx+gkhRQL3zE70IbKeNR5Urb8=
X-Gm-Gg: AYBFou3I5mG3vGQ8T021o/YNJ1dumk6adN1x4+30YKEl5P2Vf6OKyxSNnxXTbzEVzLa
	5QSGZHF/Wdq9VEwvBlbIqDP1BVgoCjdZg3oaMWrbfvZLMvNH3DBYJEQstCkTCY6r6IknnT7LI8B
	3y99nU3pHWyEGJyK4RNmVDrWFb7cSH6zg35UDMqBXw/V55eZfRIgJ1IBxnepOt6L9ewTU/+ts4J
	dYAzRv99EMFloyUb3wja6y7hvN46NYuItWZBd5UrGlRgB65ReiRSgEtgezI/rpPNkGsfo5+P1NC
	2Lz0fxXavdJy8e8pBJwudMf75jEHJvnirLfu/PxvVcEAtLxVwkNj0nes0HoSPVAY3X6CFzvmRXp
	Dz1CTeNcFrcSYy0D3hV96fFCCb+q2Sf8XCmP8FkQ13sH+ld7o9PT6BbeCJ74vt86a/EAHCDXKhF
	rYirvuJ+rlBUTaECOWdK+lWNZ0Hyp9ZW3ANvjiuHy0RnOSxRi72tvUdoJHApsm4lYapesV4OH9x
	fzXrIXX6oQFmlyOoIGc8tzjcLfgcTvT1HsFVOcHAo2pjOxbiXhXx9GL
X-Received: by 2002:a05:622a:1389:b0:52d:ea18:a8f with SMTP id d75a77b69052e-530548e2cc0mr6156201cf.29.1788458014775;
        Thu, 03 Sep 2026 10:53:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9103f22afbbsm1823116d6.8.2026.09.03.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:53:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x2Bcy-000000001zX-35Hi;
	Thu, 03 Sep 2026 14:53:32 -0300
Date: Thu, 3 Sep 2026 14:53:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lukas Wunner <lukas@wunner.de>
Cc: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	ankita@nvidia.com, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
	Aaron Tomlin <atomlin@atomlin.com>,
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
	Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <20260903175332.GN2890729@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca>
 <apl39vOiMPP7VloW@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apl39vOiMPP7VloW@wunner.de>

On Thu, Sep 03, 2026 at 03:36:54PM +0200, Lukas Wunner wrote:
> Dan was added as third devsec maintainer to host tsm.git:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/
> 
> Jonathan and I retain access to both repositories.

Fortunately they are on kernel.org so Konstantin can always recover
anything, we can get to that when there is a community consensus on
the new team.

In the short term Linus doesn't care so much about where the tree
comes from. Personally I'd rather leave that as is until the new team
is ready to put work into it. It looks like there a number of things
that may need preservation..

> > This is the only time Europe could reasonably participate in,
> > obviously it is not OK for China and Aus.
> 
> FWIW, I'm likewise based in Europe, as is Jonathan.

I was wondering if we should try to have two calls on opposite
sides.

> Obviously, one cannot separate discussing Dan's work from Dan.

Yes, please lets all have patience and understanding

Personally I feel seeing the overall work finished and products using
it in the market will be a "in memorandum" dedication for Dan.

Jason
