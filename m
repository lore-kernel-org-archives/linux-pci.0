Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E53CC7F1
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364886; cv=none; b=KsqkKnfRbmRxFY9i+5IEbe01+xb54aMxKJhCeVp1WWilepZBFB0+w2t20+Ka2mWhHduAzid/UCuDfpFxT0gnDNB5tI0HDRVJ3ccOhjpKT5xC9nhfiucOS+joyJWCcOEAl0s3ErJLgdgxv5JCNXqG33ltGjDHfemNSk3EA5Aix7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364886; c=relaxed/simple;
	bh=KXs6qNQwH4DBHRpS7hD+hEdenmQVc94yFGCAPMNNEdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu2e04VA8C340aqT4avFM/gMb8vosoB4+qxDnybUhcTXN1RXfaft8CKdNGwfDgeuIZsgEvml9/FQ3VUKdtqqo5RL+Uy62IvrnmG/FfSb0ZnewHpJHtd3GirTyI1ES1lD2KxwQyASdllMHhIU04ci6PfCOfw6yG9vBsBFDI1sZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b4583f0a1aso39184415ad.3
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 05:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779364884; x=1779969684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmzekUUgXNW9PtEwvumFbVkEmkfnVIVC+bSfznNWm+c=;
        b=gsuX5h9aSLVTWCfCsIf2K1PDYon6Adib2IEMmQVfMFH6ZUaKoRAL5OtFgUK/qBq5Sl
         7iC3gjR1b9c+K+l+XjweZ7lXmyB1NbeLeWy4qg+hTEU+zS7B0BQrgBlZcg8oNoJGjSLX
         n5fyE/js8cy/AtgZA2XP+j2uJqbzkbEylsBKKtbIQWQzY3YAgZ9S4SyJ5lMep5OKC7r6
         R3c+sdyEFsjrNYhNEhEc3/kpQ/FjQPVLL4q7skibGJMxREznaiX6YcE2bYkXZM+IpAXu
         JDz4tKf2wyaD4U+wGK/qba6xTos03tTVgTuCv99BJb24GzSjvzqdjeUfA9uU7AE6fX/J
         fqjA==
X-Forwarded-Encrypted: i=1; AFNElJ+SG0hnrbLjI4KFgPAgqacuxamMdbZXiBSrrKnuIaQECVRivuEqKp9eF0oybdRLJ5g+S6xXPSl6HHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSm+rnrPHFu3O4y/GuGvha/+9ZNkuKxhTZam7eIwzYjyYth4Nx
	gohTLzqw9X6eJRUlIUCJjSfav7Y7EgxaqDZCYtORxlBHB3mS7tAFVTOn
X-Gm-Gg: Acq92OG4/2MXnxkWDLgZZ00+H0A+SiHZwekxkMZuvDUkJHoMPCdTDrdXhCi57Ddf+Me
	4qXm0sp4S35ojDlSu20vi0NqHmjlxfyGepf0ASOQN3/wUJ9fDfTULyNxT+563ITz6ylR0izJmeO
	jF6lof36bCYDQ5RmeTfAgVaMtGa6GNZEqqDDkoL8biRxBRFdYO7zelWEGJV409AHw8DvMCI94vQ
	ZORxAFz2H3BwKmv/3oke6DX8Ojjfrvm1h1MUAsYI8GfLXTbN6kddNEGItIDIUTprEznhF/AXhjL
	ujS8xCZPihciaKQIG4AdjXGRmTYPb9Dj1UF5PcwmKJSBxKo6gRaGSLIKfW7KNY1TpGMBRC9w823
	Etrxy4+NfDjn9NXydyHfg7jEd0b4OQlOdXdzDMB2OUxquY/OyaVZxTXZvpKWD157SBI5RDs0g+f
	hi9I7kC7K6naUXJ+DhDa/OdgsuV0eErhVtmbK4ip6gwddflzms6JdyyIGq9rMUyudHnYMSap1Kb
	4ApKQMmWuyFcqHXxQJ/Dd2cQNdI4E5UQKel+p7eA7daSD/e/F0+hm4DyYYLxNKAyh6+QdZHZw0v
	WzXc5OBzbHnvgyQsQGuacGgwgBJEqJw=
X-Received: by 2002:a17:902:e5cb:b0:2bd:6cab:85d with SMTP id d9443c01a7336-2bea3091c1dmr27529935ad.3.1779364884180;
        Thu, 21 May 2026 05:01:24 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9495041sm9418365ad.35.2026.05.21.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:01:22 -0700 (PDT)
Date: Thu, 21 May 2026 21:01:21 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Gianfranco Dutka <gianfranco.dutka@arista.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/sysfs: NULL res_attr slot after kfree as defence
 against double-remove
Message-ID: <20260521115906.GC647881@rocinante>
References: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
 <376c679c-8637-d19a-48d1-165d8f2fc2f0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376c679c-8637-d19a-48d1-165d8f2fc2f0@linux.intel.com>

> To me it looks more like pci_remove_resource_files() is expected to be 
> entered only once.
> 
> If this change is accepted, the 2nd entry is "silently" allowed whereas 
> better course of action would feel to catch that in 
> pci_remove_resource_files() with:
> 
> 	if (WARN_ON_ONCE(something))
> 		return;
> 
> That way, developers may become aware the code has some lifetime issue.
> 
> (I'm not strictly against your change but I think it would be much better 
> to have sane lifetimes and catch offenders.)

The upcoming sysfs changes would remove pci_remove_resource_files()
completely, so there would not be anything needed to be done here,
hopefully.

Thank you!

	Krzysztof
