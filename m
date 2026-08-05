Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3CF2E3FE
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891338; cv=none; b=o6iCh7ix7yNS0q4giQmatuGtEGdvC9aEQaB2LafRVoJ1pkgS4JJW4HHDXihp3fGlM1N+g1J1wO/EPLZY1/CfbsAt78XJAO9ICg/KQpwon/BpIHpI/byjAJHh+RrV3i7tlQJxLCvRqZMnGEFHXqhlpfFxWWUlnOfdt2r4BvkvLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891338; c=relaxed/simple;
	bh=L0p0VCpSbh9Cfa3QK1gAYb1bq95q8GTSvQusPpTmsDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDKsvHnZ0w36kV91Q41adPWOipVxpcKTLJ/ttKDXgkWlXcmlk/ludOzH6XKX3pV1tp+hT6nGZ9rH4AfT6j0Zk0h4bbFq3bUI5oYsKhb6p3GJnjFliKWs8uRaIkZjSq7OXBbDpDHpiNx7plWxIgSq+5bceuj6IQjpGIUXegTrZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XCgimF3e; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XCgimF3e"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52cd38ddcdfso2391771cf.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 17:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785891336; x=1786496136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L0p0VCpSbh9Cfa3QK1gAYb1bq95q8GTSvQusPpTmsDI=;
        b=XCgimF3eTwduGCGRkCWCmo+x3FtOvWhrbNR+F24MjGFIUAkz0yQSY5z45NY19mR1kQ
         ub334b0r0Q1kNASt2LPewL6240q4utxJDiGj6gLPQzSdKQR1LkMuMgW7Dq2mkMzt8S9R
         +AoZ/8IFjzfPWRJP/gF7453OvdjY65JfHEmPwlurQBPi+UoU3nzgbUEmnXLmF9R3PUft
         HlHfbOw8Ry5HBEdasLVxfDyY9zhRNxOtw0Cw9MVmpaD4KRKtAbYaD9vYPJvguDnRAsZ9
         KAL8+Fu1S8Ht4vL6G7g+fshocxcg+t9WalGkHRICw4ApYKXjqCyP8Rv/sjs9BjI2Wakb
         Xx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785891336; x=1786496136;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L0p0VCpSbh9Cfa3QK1gAYb1bq95q8GTSvQusPpTmsDI=;
        b=QTbkfbuaRRr26tjLpfFgSQUL+OUT3PetlZ+gRsQub+oDJLLpirVtYsBiO6HqWh8Y9s
         cLTcfxquYfgE6ZeVGT9/BHM7xbmiQDq6XwBtu8RyH17oEfQBCNm7M5SnYgflMQBrb6rA
         kRh3x4d8bi4I6amCej7aZqMUxRxFwYWXiayKEaSA1U+s6JytIFrt5PS19OVdtb9QK1T+
         YZ4YF387HFDXBKLs14luwTtY9xVhZCbsSs7UlEqz/ec3JRded4t4V2rqoN9RzktTlTfS
         QZjaHsGIkU6w5KPu1B9FKABW4eAI/Sr0sDekEWsoal98Y9XYH7b1k0TQk0ITQ/42cbx4
         o4zA==
X-Forwarded-Encrypted: i=1; AHgh+RpgYVHgiWNH5it/m5hBSDsrawUekFmgUJmpY9M29DPuqRPnlkF9wSikVal8JdBKaSMZiedwObD5Q38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXI1BHkjSohbQsZO7jjM/DYkJmyCzgPDAr0XpvL94sWt62lPSy
	XsyjH1HCAQykySnMjlK2KJqEe40Xkn8Rhpi+xZUUktFn7aZ4IrsgFRNQVtSIPiS06V8=
X-Gm-Gg: AR+sD10OUshKUfWFGfdfYcXvblUFueaGi86PupadwPFeLsaf1MHwuBBaqlMaExiduL3
	XDr7f7nRQ1s2hfH4f/kYBP5+YFFAHg2df+f0YtmlwF0z/IoAa6x/RG6G9kSL1MnlP05JWEmE1P6
	SZuv29xR6llsXsNwHhtmenpqm+SICrnmYmaqghccrc/Sqav0lJnPEGjO+UP5zw73l9Rlzm8k8Oq
	AoXuiI2exFprFjdEf7OVtMSoXDJYC/Soj/Z5X95FT9vp+eSDv52tQYUdmlraxF9zZXGNL/0Xz+e
	qolbxhfUxGb8/ITvOi4yHU2AZtxRNeT3/9nFklQgVemvhPzSuK87b73uy1Tk1rGk6NxxhMgLexq
	n1nSuak1Vx2PNyNtnCp9U7nOmETbNYuHrSY2laInpmPlhJXRTRYdalfXMZEU1bxd7zCP2Wpncpk
	9yX+NrThy6ZS0RsXtL3f8KwVF1TdTli8XxuCVpJg==
X-Received: by 2002:a05:622a:58c7:b0:517:5b2c:6aae with SMTP id d75a77b69052e-52ce5fbdcc4mr38577871cf.13.1785891335649;
        Tue, 04 Aug 2026 17:55:35 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce87aa1a3sm6538131cf.6.2026.08.04.17.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 17:55:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wrPuv-00000000Cli-34Ni;
	Tue, 04 Aug 2026 21:55:33 -0300
Date: Tue, 4 Aug 2026 21:55:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
	ankita@nvidia.com, Aaron Tomlin <atomlin@atomlin.com>,
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
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <20260805005533.GB28508@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>

On Tue, Aug 04, 2026 at 09:48:30AM +0800, Xu Yilun wrote:

> Glad to see you all here to make progress! Intel can also help on this.
> Can we have a meeting to discuss on these topics? As Alexey mentioned,
> previously we had a bi-weekly call, perhaps use that for our first
> meeting? Or what time works best for everyone?

I prefer we defer such community discussions till September, that
seems appropriate given some dates I've seen.

Jason
