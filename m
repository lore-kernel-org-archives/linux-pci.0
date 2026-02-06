Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED427AC5C
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390430; cv=none; b=Dy+O7AJVmLEDfCNZW9YyfpP3Nbrpzo451Lg9Q+i73tnl+g/qGeHqTnsJ5pNmHh44Iz8AuAnMqxBTDfhUK/5IDSgEq4aAgteuwce8fFKXb2tZ2Q/o78tMk8lbPDq+tJEN0JoFU1jEjZZtAP2KOnT9m0i1TBEBVEVvdcAZtytv0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390430; c=relaxed/simple;
	bh=bRK6FzbFILa5Ip3b30D2dURLw48SKMLMEvj/U6Yrpho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1trpXrswMScS/Xj3YjyDiQAOa+JgeY8H0qhlJkTFuqzkKuRJtHR7X4wH1V8xUICSEi5rzf8c8oDETPGJUgbFX6TVOkDR1cQzNj5DUb/YZp6swPmsGF7WkMPQ57/DBh+9i0Aw/JMvGT5Jncpn7TXNwTs5T3ZeS3nchK7DZfHG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OkL/ngo9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OkL/ngo9"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c5384ee23fso89503485a.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770390429; x=1770995229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVq6rfsNPgHkVD9Uk0vE2z8beerbYIiR5ZWjlpv17tE=;
        b=OkL/ngo9mkpDZyWWMk4rMdz/rkPgqJ2v3zkRF6iUNPtaLZqXlA9gJc7K2UY/Yejj4r
         6Z0325Kf39T6f3sniE/n/WPWqp89Anc8ElUdNOfnSBrT7NI6avH0aONCDbfpJZJMcW0N
         VQG050Sud2FIEaofaq9cagnTsdu8UgajqEvYBfnC8pJvmNSR4j5G4EJL+tnxlKFQzvcd
         fJ+mZBnPKyYE4Uj37Fbv1hczD+O6uXi2oN4JlFIUE3Q2/eADiQN/kv2EHcm9c1A7m2d/
         4GnUuMTt6X285aqGjv2le16HWIToUHzwIKATFAfSXMp4WHx+DpzWduglF/bp+a2gQnKu
         LDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390429; x=1770995229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVq6rfsNPgHkVD9Uk0vE2z8beerbYIiR5ZWjlpv17tE=;
        b=SDazwxFVRcpsymCvotDWUL+RY/PAUpFftobfjVBM/Wmm81818eQOQCngbefI+PJd/e
         VQRe44wfp2kcQMGwz+11n2pSHTQYGvhEpAxo5eIeacLI2PdMC13Bse4h0ViyAjgNNx95
         5eaonTLzXASYlKq8W0nuQ0ftHfwcRON0LfWhiyj/YW+pvW0owz8WswF8PJtz81MD8xNG
         n8goHLBrkTIUYzjFqomIZ2SBi45xo1/hmsO8D0Wl0jlOc/lWyVAN/kCDcaJpz73Ecxh+
         K1uWWGMksBCDnyTyOyUNnQzmYLNmC1TkWWPGxqT04/QoGIk41QJM1KK6zYJUx5A5G+qm
         thlw==
X-Forwarded-Encrypted: i=1; AJvYcCUJaEpIZkTZcbWbXWRkyiAecLE14K62kx6m/eXBvuDbKaKKMpMcOQAZYM/UL9f5e6r52eTCnbSOnVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3Hu0LKbyYjgdcbTRTWG32osF2KhwwCC3hyaHiQzXbAlIZ8th
	Voh+odeVUZyjQC0nti81mQgyY0GFhXHCKjDpZNT3ta5R+XLJ22JzAUwiBIkkaBg3IBc=
X-Gm-Gg: AZuq6aLa3H1riIgebONu10/SKlVH3gYiJeglrve7TgA8jq8HPebj8k8ODz5cKuyHlMN
	H/hNzerrU9FRJsL/Lt6HLQxfcGNotF/NOwFG5bR821UWqcz1jPZYVzxpHIBQ6gFk3bXlVpKBptw
	LXJFx/5pfkCY6CVfAt5Qv3fuw2vFGttONCmzySHfzN9teZPBwaQFIE7O2VPKq5Ch0Amr6toqplg
	0DGm8guuMMFZ+JSGoTx2h3HZQyVgrKdDA7ex5uc1WG2aWpywcqOjd+MRPrkfYQpndbbEB2yec7k
	iGadPS7L3wpXx3vrNeRn+wJGndM3FPo78XOuqLninXJ92A4z/MbBkw3Qoa3w7kjhZxUXff65yyv
	q8vdBzDK3mD+BRc3wqar0Dqk/sq0peXXyyMbCTIZ88git3VyhrBxUiAD1JWM9Vo0mQMYsY4MHVm
	5R72YCrfVFfGSn3tNPlOgCKYuidD47fo/NzuGMb3EQ67XPWc+4D3hUn1cfekw/oQKAXJ0=
X-Received: by 2002:a05:620a:2906:b0:8c7:1b3c:8e8 with SMTP id af79cd13be357-8caef9d452fmr344688285a.40.1770390429177;
        Fri, 06 Feb 2026 07:07:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aeed7dsm163905385a.18.2026.02.06.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:07:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voNQJ-00000008ZWC-2gJs;
	Fri, 06 Feb 2026 11:07:07 -0400
Date: Fri, 6 Feb 2026 11:07:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
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
Message-ID: <20260206150707.GM943673@ziepe.ca>
References: <20260206145254.GK943673@ziepe.ca>
 <20260206150505.GA58808@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206150505.GA58808@bhelgaas>

On Fri, Feb 06, 2026 at 09:05:05AM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 06, 2026 at 10:52:54AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 06, 2026 at 08:46:51AM -0600, Bjorn Helgaas wrote:
> > 
> > > IIUC the current situation is that for these IDT switches, ACS SV is
> > > enabled when downstream devices are passed through to guests, but
> > > after these patches, it will no longer be enabled.
> > 
> > ACS SV is enabled at boot time if an IOMMU driver is present
> > regardless if guests or virtualization is in use.
> > 
> > Linux doesn't change ACS flags dynamically.
> 
> Right, it's just that this series effectively un-advertises ACS SV for
> the IDE switches so it will never be enabled for them

Yes

> > iommu_groups will correctly describe the system limitations with the
> > ACS quirk path and so all of the above concerns are taken care
> > of. Robin is saying the Juno SMMU forces a large iommu_group covering
> > the switch anyhow today, so at least that platform is not affected.
> 
> I guess REQ_ACS_FLAGS is what iommu_groups looks for?  I looked for
> such a thing earlier but must have missed it.  Thanks!

Yes

Jason
