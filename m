Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A4472F83
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623173; cv=none; b=cEj8KNqMBWh4Z0HiQz17+44UrxLnw01366fRjU/1kpF94BmiitBs4bCruYTNuEOf8iMTdnfPDu9JkuLw5HHYD2ik1ckSdKZdd+frE+8y/5ZLtU0O/nb+d50FfQ1f3izHs+hEdSQZgzw3DfGoeBDvuZw/89BWHrj+QNRz82g1vEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623173; c=relaxed/simple;
	bh=J71Nb7FwK/y4ZvkNO63vb0baaS/Nh9iJZnBAhcYjO6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpsNS7Bv2fW+ODpVqAOAG3o4I+16RogBtvLGOAKbM55Ms6gnEJGrxiXuwtN9GBsym9WIyN+6PFkTF6RPg+M8qpi4CFb76fJWHJiG6vk5WA/Ci4Rteq8ceV07VIOd2/C2odfjB+Rhsg+3yP48wgOAiYyif1pveSnErMuWoypSmrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KPlL5Z5n; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KPlL5Z5n"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9063b380982so7441436d6.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786623170; x=1787227970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JzqQMoNbaC6wNrYu6a+WqecNk64VsZCRB0iu7uKoI3Q=;
        b=KPlL5Z5nsVMOInKXLaajI563u4pfc0njUwJ4jyb5Um/aT8L6Hkomd9zua48pRn4Yqg
         B8OJCQ+rq/UmQq8tubDFBE5o5+uZk+0pjmX03c8m3bkO8ZChEiXT/29wQsiHumuKIsK0
         qDGDdufYjJVtm1l/GooIPo5ymEGkes0GSu5287unNNuis4CAsDEPEpObHObKrHHboIMA
         gGcmJngU0JLI6wfbzzT38WtADNSjn8QcAGCIhJBhzORA/QPkF1U+2N/fTd3MYjEkRgsM
         tqfFvYMk/bvOJ6D2WPh3+zNXwgGDePvUW8Ypd5+HbQ9ZTFpT2GexY9Ce8X3iPXTWkuhF
         q4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623170; x=1787227970;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JzqQMoNbaC6wNrYu6a+WqecNk64VsZCRB0iu7uKoI3Q=;
        b=Iuf3N6gg5vf38QWQYZLa2v8C+n5Njg2eE6Kc5DtTLLI5tnHuIS+NbKv69PjFUTN3ls
         tWYiVlTQR6tIpH4InsFNI67U8JIhF6h+OJHZ3MclDU0cXk+6QI+9/vZB2U2VrtmtECWx
         TqUDv+H5PmUslSaWh4oGmCESCsAKPel+9TE1GQDXzdJ8/spKoWzoTNbOYPyfsPKDHxWL
         JyMV79bxHNvmxQsw69lm22NL9rB5pw805M7X5oX7F8jWhz06q8ZcwRNMHOML73xqp/b3
         R5XJCmFH4VP3z8oaIvbhr66hdA75dUZSH1C8RK5FBv9+IJLRJJuZMfM01TXRZD17pK22
         G3CA==
X-Forwarded-Encrypted: i=1; AHgh+RqAET34Y3Vm3ZvgvniJ1wMkWtlLfRLPjwZuETkdSxTLBt7jL7LhGa+bnEnSvho5fv8e5en9VQ/VWqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXoUvS4R6GOajV4BqPKuAM4LRK6hHlAVn27b36TBUPyxeJVZ8x
	KfKFMcUdLR4TydqxRc1fJrTTdJdi7JxLt90TjOJvAlTR5PYI5kN1C7U+IihfxSF8BT2ZRPgrZgh
	AEicj
X-Gm-Gg: AR+sD13Xe+t79Z2YM+AAINPtncS5CqbHB6xHYUuXHhV5oRejF0Cmv5iI3SYbxEVHSu/
	HoSBnriNOPwQnOM9P0XMz5U4PapT0c+Hpwrae1eM+yr9tEAVXD1P1NeC+sD5OcgA7HY+2WhTKjw
	CjgRt6JRQ2d8r9OeKmB8K7pFNA1Y3QD7Irrx86dfbXURyKNGjvtxIhhXb4Dm2rgWw+i1UGesukz
	PhJhoQDecWGjgdu4D3JP8S11I8IPuON3T/scrf3r3fpEreFUNgTUxlbsetYLBulgST21D+F51VU
	3Fn5qQ54T0Ft4NCugURM/E2ICIhmddsdkW8kTICGRrVkzgoleGGOdf1R9Y1WqAelWPwoznLo5zA
	CP/5QA9KBnYlD5FhNN8BqYoE6XLBTAWQadkAKDkQdidvqYhUrHq8FhmIKX+NlvrnjAK7hEg5gWW
	VQvn+MDwGbc56MZuwEx7yyjrH5DYfFQZ13aRWupw==
X-Received: by 2002:a05:6214:1316:b0:908:93c5:25b5 with SMTP id 6a1803df08f44-90a80ba1fb2mr49778596d6.29.1786623170333;
        Thu, 13 Aug 2026 05:12:50 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a81a9e4b5sm13362406d6.34.2026.08.13.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:12:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuUIi-00000003kp8-3a4m;
	Thu, 13 Aug 2026 09:12:48 -0300
Date: Thu, 13 Aug 2026 09:12:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260813121248.GJ662699@ziepe.ca>
References: <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805191116.GE28508@ziepe.ca>
 <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260812205737.GG662699@ziepe.ca>
 <BN9PR12MB5146253D30587DC820486F4FF7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260812232638.GH662699@ziepe.ca>
 <BN9PR12MB51462D89963C912121E9D780F7DB2@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51462D89963C912121E9D780F7DB2@BN9PR12MB5146.namprd12.prod.outlook.com>

On Thu, Aug 13, 2026 at 12:11:48AM +0000, Deucher, Alexander wrote:

> > Huh? You've explained that SME doesn't work with these GPUs? How are
> > there any working systems with SME turned on already running Linux?
> 
> No one noticed it because the IOMMU driver used to default to 1:1
> mapping for all AMD GPUs that supported ATS and PRI for

That's back to the original point, you should just quirk this broken
GPU to require 1:1 and that's the right answer

I thought you had said even that does not work with SME because of
some HW reason?

Jason
