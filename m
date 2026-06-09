Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0F492510
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019309; cv=none; b=rfLz5gYXs9aGMkm+Id4ahdCzJ+ncoIf8PpiNNxwh0g8Y7GoQrBzfLCUkw3uB1iylasiNiaqdEoHgvlKxtaX13KWTZT7Fuc4TH9DjNUeKNQzdBz/LZor08q5vXrpfhi4/p2spgAs82o7Fman7/XjTnV2nKzwidls1Oc1SQrI8RuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019309; c=relaxed/simple;
	bh=IqA7ece+KivQIz+QnTfJlr8GYFK3bFrh9+lzAaVoLks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlM8hVezpzO0m258Ke1VLH9bH+nLi65x42fXI/+vl+uX5gcRy/nAUhsd1qvulQ6p8cvAIeJBxS9OkmRfAjuFCqat+O+J+9qIlOYJmt8GgwTyXnrTRAU62MQW4rn196EUxEWv374GQ/1NjrfWcNxcCy9Sb7t1/nCr4VH/ikZyp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKwEITMm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKwEITMm"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf2911f93cso448905ad.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019306; x=1781624106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyfvIUyYOvTVt/UpRIulwDCiz4s89QiTYmiwF1UuTbs=;
        b=VKwEITMmY+vIF7jLHPm/G3ujxm+/qQAK6QbACHBRHkH8m32SFVruEegpcyXlaCBVqu
         VCjsa/rdPcJp35mI2h6n9tpOuGNWUuaQ672kL87BfJ8fA4XiLfAS8dzGhYCMsiHiMQAQ
         u+kAUtHMKxkaqatkoNqFsJd2xRtBbkpXfUlfDm8dXmz3XNIG7/GWlufKlgCvlVJQWpoj
         jT//BncqBAcfCRJDw4CjgvZ8fILeeTX7hsPJYxq050U22ausROyCbFBo/3kXBtTRKTKb
         gMtpCGmO2VbnxSeFNsp1948l+WUDylvlTrkzF2nmXkyoGoJxP90a3jZkRqTpBHs/ayhw
         x7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019306; x=1781624106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyfvIUyYOvTVt/UpRIulwDCiz4s89QiTYmiwF1UuTbs=;
        b=nHT6llS7Z2dMYTC38I2TJfCR+BjpN6hvps6PzqIvHFYmLnO0o0dYf26EQe3Kv78nX1
         zhV1NKrsnQBNqU0LJLqGbnX14yVhwk3SVqTharIBOzAGVDC0C23fINMXpM+FlTlQpPqm
         RQYF9e9atN1Xnk+fbtyw/1cQV1vd2bLsdyhIToL81Yq2xTfc7MCCn6MqMeNRA1p3SmZA
         q1fAM/kXfn7PCKYDR6Soxuqi1VfkNKs6FXWLl0J4mqke766TK+a3ZDN+KY+DM99UUouo
         shkoXAoGcMWahgo3rKR7nacOps/15UZpRfOPnWQt+uQ2hW6JjGr2cPFkaN09A+ePG9FB
         CSkg==
X-Forwarded-Encrypted: i=1; AFNElJ+tP9kX1Wcypnrot4poSQthd6v07+WjxyAuhFAEFORoHqnnS2ziGH4otVJVcbZXItFkPhVRK/fBmN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqsuPAuttYYlxml6JQ1eEuFHWDsJJIrx/zQwkKzjeTaXdqKMA
	/KcyeKFbRnr3+Pl93pdr8xv2o3ExRhw2xNF/07LSgRCq9RyKz6gN9LdGAMxdBB5hUg==
X-Gm-Gg: Acq92OF5HLux/qoyBgfEwikoF7xOyOYuN/9uZwIPGypSH9J70gL51pRsjhWrbJjzHbK
	1lwyM8dyRAKPBN/GOrRN2lTWLv3Xh1lTcZ6i8EXUD1d4cSnD13b0DtJSQbyeAU8eoys0kh/4PAC
	7B8l1+5j1ZUlrZNCGc3hAKKnfW/YPrzhrdkK780Gvjf6JXQ8+34+/OuLV7PKswHeqXsOC27yHGc
	gKHyL5mO4s2/R8upYSyyi5F+ECAljoiSeifhKjW71VfNF6MIiPUCshHCooofbBRJbJ1yJ4Smcl7
	M67uJmUKNczZgWnBZrJgHplo9OfZJj1wFuPI/OXicN3U2Df+A4tDYqu55z4JzOIQmxMwOW4fTHG
	1je612QhDk+vwNDhQA5X8ooi6C4BRcPGD0YojE4aHD2KptcCr1CylUsvKPg3+YjG0H8IWIVv0Ub
	pj0Dk6zLkfHHIdiFv4HR/XjnXUoK6XlJWVkhiNyS+mrkdbRcWhYXq0gT1Wzjn+yCg8Y3VNraq4C
	V1uMbr+/w==
X-Received: by 2002:a17:902:e885:b0:2bd:7e8e:ad56 with SMTP id d9443c01a7336-2c1eafba702mr7653595ad.6.1781019305283;
        Tue, 09 Jun 2026 08:35:05 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm24737580a91.1.2026.06.09.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:35:04 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:34:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <aigyn66-xQ_9JBW6@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aiaeOVomxQZhoM3K@google.com>
 <20260608181640.GO1962447@nvidia.com>
 <aigtS3UDdhUGp3m0@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aigtS3UDdhUGp3m0@google.com>

On Tue, Jun 09, 2026 at 03:12:11PM +0000, Pranjal Shrivastava wrote:
> On Mon, Jun 08, 2026 at 03:16:40PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 08, 2026 at 10:49:29AM +0000, Pranjal Shrivastava wrote:
> > 
> > > My point was that a FW exploit can meddle with the bitfields of the
> > > ACS_CTRL to spoof and mis-report the ACS flags.
> > 
> > Devices can also ignore the ACS flags. I don't think this is an area
> > where we should be worrying about devices being actively hostile.
> 
> I'm wondering what happens if we preserve IOMMU groups across a kexec,
> but a switch's ACS capability is dropped or the ACS_RR bit gets cleared?
> The incoming kernel assumes that it's the same ACS cap from the old one
> 
> Now, the incoming kernel restores the groups assuming they're still 
> isolated, but the hardware no longer enforces it, silently allowing DMAs
> & breaking isolation? 

Again, to clarify, I'm aware that we aren't preserving IOMMU groups,
the incoming kernel has to rebuild the groups. My concern is that if the 
ACS_RR bit is cleared during the kexec window, the produced grouping would
be different than the old kernel. What happens if two devices on the
same bridge were assigned to 2 different VMs?

Thanks,
Praan
