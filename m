Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481047A886
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281378; cv=none; b=XiFQQbO8to7oY779We+15GrW2XkEK6MtiOXQ5Lt0lLun3iSuPhpz3aqM7zU9GeXn0soL896ValYLIAVRmPLM0MHylUWQnij/F1DQzhWVYmKUsiaU6z1rTb0n9PtC08tG1HrlrpBVSLtEkxiNxzvLxgB12eWM+6E9Ptnorij2/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281378; c=relaxed/simple;
	bh=lMzH1GE+iKbOtPjkrcpk63ibuXDoMGMXvQt/koZqnqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbIemq3r3vnJNStlKl3t1euxnB61eFIqwSrKMkH+KwKMYxX6ig7Sw748u/LBhA0y9isMi5/v3xdfExspn1SJaDraNAo84sbORN07NARDea9YN1OyrJu/IlAi4QQ4EenQ0Ajdlt97CLuOfVeqZBWe+1Cwq65XSAtPfoDBZjFrKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dA8H+8G/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dA8H+8G/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dcbade417so339514a91.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785281377; x=1785886177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TcnuxxaLXXCjqu1rDtFOdNvCOQDXn343+yTz8KiZZQE=;
        b=dA8H+8G/Bbd2IhvD6pG0XDRzfbWQUiFWumDr5vTewu47GcB3hjwU4UE3DQ2P2AqNgu
         SYlwE2+2KamUjVcIc36B7ssMyisuuHR7wCnQRLduhA+QJHF/qRfJKijpUIVZ2vRjwEE0
         I3suP3jGsCwmx5+MaBItSecs82mVRbicm+mp13aOlV+0s0mt0/IfJUkeZY7tB4HpdA51
         4Y2/RrP5Du2z+ziL4fRxO78bAgbilbVFW7V5R1GJ5IYneBQByG4XIosEWLuZxJERcWhq
         ymhWXXy3bIv0B5fWch5NPcyveLpdiXO8U5qDvIGgraQzs38agTRUkcQ8+OjQKjLWrX96
         5a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281377; x=1785886177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TcnuxxaLXXCjqu1rDtFOdNvCOQDXn343+yTz8KiZZQE=;
        b=h3PlshjYgTTsMFVdw0CtI0giHfL6JNuZTnk14Y85nAsCrVeboz5vfqSYOfFJPdDA1z
         QzOZ9J93XlPP16euWfkx9I3ijs/GoTmhohwDWW5u6LlnxLXGB1q3yQnUZxIQBrY6AuAW
         sXgvlE4sg+P1bNJnR42YW3moMGBWtDx5lk42UYVyXAPTnIypay0OKNrg48fR93zZzf9N
         l5DUZ2aLVJMYxDK4YUszYBcFM4PbSRpnI5SDabgjxWl1o2AX97ZJW2qfhNDF1bsG+AId
         lp3oEvIPOaGLHlpC77LFVYLjUyrEHIrgZNeaxQylYQ31c5z5idUhgOLE3+GrWyXKvUYh
         gx+w==
X-Forwarded-Encrypted: i=1; AHgh+Rp1Rc/0dUSfulR0AFpCrQmFG5NRfJ+H5gmRZ7xxzYVt52bk0Z0z5vpX/OrqAVwRJQA6gAGKqHC1vqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVNLJgaM/LQuM9Ia01GUlWPBUg+8gQVzON25xO3xtpKTFZkCr
	SVs2cKMAOXpASxBuLGJgWKKq/VwICzafaw21mI4ncdUsANtc4YFb6bEroKFC10Y+rtY=
X-Gm-Gg: AR+sD11zdhqD+RZC+J49ax53w8Pp/nY/RZIVPtgl7/qN3EGzHIlBv9mlDW1/gbu9RQD
	jIi3Zc3efVWg09hgXSMqDpKwN1XgVSwuc4JZWJPeyBQWyHsCXab5OnYb521F1B37HP4+rsz5uy8
	VuepQv8yAPb7DQWs0v0RAgbAYBYWoo1Se4ezE7uhDU1xtWiO6aNOORng1eOZ7uUyjwaP4u8BHFC
	w1harEvZXxhGySdm0kBKH4Pr98F2s4SUumZb6uyZfGxja7SG1qZm1O/97pAAvBPbJ2Rakjk0ONs
	5sTg6s1eciDcLHKTX6Bq+CE0VRGJnE9QycCKVYWThNVfEjUnW+x14UGwo7iRacEb3Wh5+04UT7h
	01S/WbMORtE6vmNJYQ59VhF+QV2wWvDIRB7FCq2YPixjAG+XiDqMUeJ56IiHnMm1wiSo2mT/5by
	mOZ0eqo15N3cKQN8nCaEshmTXhb6wTQCZAh7WNsPRosHLCvsVKVXs9ppcMopQ6Ez50
X-Received: by 2002:a17:90b:3c91:b0:38e:542:6485 with SMTP id 98e67ed59e1d1-38f6a37c1afmr4515935a91.12.1785281376718;
        Tue, 28 Jul 2026 16:29:36 -0700 (PDT)
Received: from ziepe.ca (d50-92-54-205.bchsia.telus.net. [50.92.54.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f814e523dsm112041a91.2.2026.07.28.16.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:29:36 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1worEt-0001oO-LX;
	Tue, 28 Jul 2026 20:29:35 -0300
Date: Tue, 28 Jul 2026 20:29:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev, ankita@nvidia.com,
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
	Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <amk7Xzm5jmz+6SPJ@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>

On Tue, Jul 28, 2026 at 06:20:10PM +1000, Alexey Kardashevskiy wrote:
> On 6/7/26 08:08, Dan Williams wrote:
> > Major changes since: "[PATCH v2 00/19] PCI/TSM: TEE I/O infrastructure" [1]
> 
> soo with the recent sudden sad news about Dan, I do not know where to start really so I just start...
> 
> Here is his unfinished work which I'd really like to see finished to
> progress with the phase2 of the plan. How do we proceed from now on?

Yes, we do, but at least I need some more time before considering what
to do, sorry.

> The direction appears to be set, imho the immediate TODO list is:
> - address "not-netlink-y enough" concerns
> - teach pci_iomap() to map mixed private+shared BARs (ones which contain MSIX for the starter)
> - always call pci_tsm_ops::enable_dma/disable_dma
> - ditch the module trust parameter?
> - add a knob to enable/disable DMA and keep TDI in RUN

I somehow suspect we should probably reduce the scope somewhat into
smaller chunks at a time and try to follow this as a skeleton, but I
haven't studied it carefully.

Jason
