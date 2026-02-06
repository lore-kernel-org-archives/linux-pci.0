Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC945410D3F
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388216; cv=none; b=nvdMCAXiQOyyNu/TB1hHAreWVBn2Gxsa2kl5veGRT3iXFFNtg9uqV3boo7Yo5zwLV1nxHdFh1qgcZMLxguoReLgz3ugAqI0QXfsxG/7rxkEDaxrZYAHO9brRZq7MMM7rP3KxXleVpytZ27lkIJPdJmqpqSYOXYaCjjsMANp9bn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388216; c=relaxed/simple;
	bh=VJUJxiaiSyjn06mFjR9T+fjRixI6F335byZ5Sx4J6MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW5qoPBjl99YMNQGQACdXa5MTd1SwVakAI25fWNX+B1DfSc1JaCoyDy6Cpx2hiEuusQ+PbqV36o7aiZeIDa2PHxR5Ueg4IJB+C3+1pgqs5f+S0uzWziLz+hz5glBIh3QYC5+8uaNorYWaKjr4WNwGh2Q/4nV3uB6hDsjcK2bCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MhRMdg6C; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MhRMdg6C"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5386f1c9fso103090785a.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770388215; x=1770993015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THMhyPMr7sNTge9zhp9X3LUNdQ3UJ8Jh3cljXKT38Os=;
        b=MhRMdg6CtqlbF7iKKGKaGbhOxe1RV3MOMli+pKnDmCoLW/3bQkQp47HBogAV5D7wv6
         0Dd9HrKr2h/dD53unnVrYBXOgqtU1LzggTT0bB0uNgru6HjjGKpkHHs2/ph2DLxC6ow8
         BvLoU7ZfgyyXglMj9sLFegIz72JE3nc4uiEfaZ8RXYKskGvDiCStEVzdEt/dqFI1uJ/3
         YPbCDAyhpNKSwna6wkV0BXGIA5Dp9INTXgG1K8W3Or7WD9Li5IY8EFDpmewKq1T6vo/x
         2dgNLZhHQIbj0kUJxk8SoHfMSk+yukranDg8yjEwqv1t+XjW66u07c2vEC7/nOAeOmNf
         Yfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770388215; x=1770993015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THMhyPMr7sNTge9zhp9X3LUNdQ3UJ8Jh3cljXKT38Os=;
        b=FAUHZO4lEU3TxXvQLFWurh7iyMWnfItC0GNWUYjwYGg7990vKu41PBTe6GiqqrdNrJ
         Wk20I2F5vJTraFjlX4NbclLntdYz8y1iO/Ljz2VpwYKjjinyrjb/DN1AuxhNXNT4bjzw
         wG4ZRdv3OcFrXJVI4y+YRw2TRDykEqLNDCbP4n3ObTSQh/BoNqa8t87tYpq7w3tMa3Js
         AE64eTz4fttd9gKbKdciz1CHH3bidZjGcMvt/Gv+24+rqJLEg9hRCaXagf+DpI6gmfCd
         PW3IVzZ/dPLyc0Xxd5YjN9Cg+AcJ2BGtxck6ZGcNYMgrs7fwl+2bpD1T+aMc2RP3gKy/
         NOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS1arnrR1xsrhy6ds5NsImsktl3mA+78Kv525JiOloig4nXoay75fs6nxwA9xIYst01d7QAkWgPFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQXiwA/astUFVWz/pBhPdvTdAGmnRWd1dKjK63zgCzh7wftBi
	/wvQAi5phB1EM6Qifgdb2LG783v7QvuYxDCEUT9h+vezn+bH4v7IZdl+uBaYQaa/qt8=
X-Gm-Gg: AZuq6aLXH0FCwVvGgctDZOBlrWXNYroyEOPIPpncC80ebEULrKmIqDdOuBM045nbTo1
	A5H2wWreS32UANHn4/IfxX8NPArIMqlv3LZInSUmRo6jz5ols3en0iCOdug6YYo8el5gW1K+X2M
	hNc+1ayBTjaQlLn81xtSHi9WCrcWZHpjEZVTRx2Qv3mPua4Qjj3PnDneHqX1UrEhXuoIoAOOLke
	GPSBcjCQiWFrm6aT7gS/xwEcs64ZidRhFVvMds+7iAIhzFNrxR/Wp+jiQHqxs1wREhgiuEEtcHB
	GJ+91HKgkfcrzDY3/4Vv25oeVO8MgMUHGKWGgK0/cjFgdSkbUlC8ZyhzUDA8xeUiGbAjyb/0DJp
	9xNDTBOKY0/jvanRfgj7hvRYJoBfqZl6GMoaogxNVYyU3lOhyPRmM0vWIx5SVzyUxi40KiGx59H
	99ZA1bQUI/I3sntob7PY5x/9EdWXnUQ1a8Z5FRM8KP8MeiTITK2oNQh000ELhm5ku0U7U=
X-Received: by 2002:a05:620a:448c:b0:8c9:737e:3840 with SMTP id af79cd13be357-8caf130a55emr392847185a.67.1770388215425;
        Fri, 06 Feb 2026 06:30:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f6badsm160617385a.11.2026.02.06.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:30:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voMqc-00000008O8R-0VMF;
	Fri, 06 Feb 2026 10:30:14 -0400
Date: Fri, 6 Feb 2026 10:30:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20260206143014.GH943673@ziepe.ca>
References: <20260102-pci_acs-v3-3-72280b94d288@oss.qualcomm.com>
 <20260205233920.GA17083@bhelgaas>
 <ga5ro3nvrbmbjubtk6xnozzc6exqq5vnkmp2pfuhtnzmpsuogz@lcycdoxtu2k4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ga5ro3nvrbmbjubtk6xnozzc6exqq5vnkmp2pfuhtnzmpsuogz@lcycdoxtu2k4>

On Fri, Feb 06, 2026 at 02:41:36PM +0530, Manivannan Sadhasivam wrote:
> > It'd be worth expanding on this and what the effect of avoiding ACS SV
> > is.  Does this change which devices can be safely passed through to
> > virtual guests?  Does it give up isolation that users expect?
> > 
> 
> IMO, ACS SV is somewhat broken on this switch. But we can still passthrough the
> downstream devices to the guests. There won't be ACS SV apparently, but that's
> what users will get with broken hw.

I agree with this, the HW is very broken, let's have it at least work
properly in Linux on bare metal out of the box.

If someone really insists they need virtualization with narrow groups
on this HW then they need to come with a more complete fix. Using VFIO
is going to open up the reset flows that are problematic with the
current solution, so it isn't like that is already working fully.

Somehow I suspect nobody would use this switch for virtualization :)

Jason
