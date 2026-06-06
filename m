Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3F380FDC
	for <linux-pci@vger.kernel.org>; Sat,  6 Jun 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780741233; cv=none; b=gNMh/4SFYd51OyW2Dc879zp9fGv/Z1RwZoyHHA51Az7lv+YeKnXCAa77u7E+EiRyjZ6YXqxYRICKx0o8rbmv0mC/7/MNoNpkqoipqHkGYhzeviUD2BWhQcKoAd5SOJZWiImn7Ie3VBKbVeMBUkxwnVEl0bgneNuPR4Fja/O15YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780741233; c=relaxed/simple;
	bh=uDx8Zj6uGPOLysfp+I7cIZoDxmiFQufsnPmzXBN15a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjrAOGE2dntrVv8HbbaszW5/16Ra0pv/E8moIiWrusolpyqjYD61zJUzyMkvCVQvdL/PCNMe/RJNqMqU6ZLGF+VE+ZW7wMRLMwslZkvGwtECRapeQOJYOZUzsWy+UQwrsyIeMGvsyx+uzF8eepj6vkGfl1CeQ45mH17zaIIzanw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJdnqy+M; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJdnqy+M"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137ff9a7d5eso16851c88.1
        for <linux-pci@vger.kernel.org>; Sat, 06 Jun 2026 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780741230; x=1781346030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rI4D0m/tct5A6mLgdnGzeGFfOZi2MuVNzAsWtboD2FA=;
        b=tJdnqy+MQHROu7CxISL0KDLhnx5fEKamGfK+HKpMFyTFDwmNJJcWtAhfH5M5i8s3j6
         tvck2idsr62FGfisGBCjyq1qHqQYiyWDO4C0GQie+t1eK3jUtrdQqQmnreQxAqrUU0ZC
         53bgy+6jomDBLrxhz4L3r1/0dUb0ZK+5OzjvkAR1x5IGw+PlJnbyCV1htjhDbgJu4rq2
         oY57oEoDKDRh3Czki4/iH9ySieMBQ1n49jAt0+rwPjRglHnK5HdhMEhckRWLoQJOAIK0
         G9QpVw8IltGN3JQ2pqk8PZAZoUwfUDlt6dn9+rWsUBP7DIMIqbpZkRUUwCcCRV8J/X85
         QIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780741230; x=1781346030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI4D0m/tct5A6mLgdnGzeGFfOZi2MuVNzAsWtboD2FA=;
        b=LOu+5Lo2vZFTZUru2jEEW0+PNuo02me9ImxwZUyoOU2JSzlH/2ZGFJLu0FFAzAkEIc
         IwEjfrkcZ+0D4r+2UqFfaMl/FTU3tR1NEIM/IQVE3h4xLO3YKuP2NXjT46DIOOXYbphr
         Ic00NNcgIABifTOBa+uX46UgDlj62Ha1OjDDNKHRHeLyo3IQJFN/WErOSydRVlv3YSvG
         2XtJtIWZEI8dh5LWyBgI33pPrWLq5RIm+T83RPyyGDDA5m74k6VCBhPlqRlj1kx5Xo1e
         m985KrxPatNvveaUxOn6Pr1HftqebQG5wtM9wK6W3rYFfuYA43CpaAuTA+jP1SSm4J7V
         kNBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dKsjIHYdacBUP9PD2FBj+sVzGaF65OkFJcynwT6ueaUoen5iGaMAYWrk9FztNrkQv95zyJ/VwJfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvkbquzIwlMiIiIqC6BX2+rOAE0eIU7EcteuoSqyG3p9vxqVXq
	ieHcvJZPyOKGGtU0EAUOifjz8Iv9ZfrTydukJqphpM5ctFgiVR+loCPrFExyjTE7xA==
X-Gm-Gg: Acq92OFTv+noWuYDtkUfwammhRfG3ByLzhlf0WR5remAieTNHsuczs6TIHl/sADSkwR
	Ou06Tgi4w0RZ/BzVYb6X+VTOiQbJvNSTzLq0C//mv9QuV9ssa/yBWzNXAum0sIwcKZuANzXgV45
	RfCZe7r32HRc31G7nShTyKjNUEptIpZVZG5MWPPF8K+RdiWSKKDedcoo/YH0qaQ+2RsltogSHBD
	aH5oenwzR3rz8mZ32qhIi1sD/QJnpOZj7K83bY2QyJvE6UGmJ+64JIu7Sj5KoGxwCYZZzuFMxVb
	OP3ozjr+uz6hdVwS8H/1mvDUOSTdCH6C/Qv7btYj3RrjZ/cbvZjmYeNZl/6VQnLriV+oUILD3lS
	WM1+mtqkwNAn7tDLnZGqB44Gx4fvKPOqRZ03vn8Jxw3V8wUZYBOLsX5zSaLbOjZx4idbmjnRopp
	J5nL/+f4BuoJmq298w9vtzRbhGZiuMGLvADUoac1xFouqs8lb5Cl35GAjokOnXkTjXSy73bD0=
X-Received: by 2002:a05:7022:671f:b0:137:9ab:2cb0 with SMTP id a92af1059eb24-13807ce58f6mr166369c88.22.1780741229038;
        Sat, 06 Jun 2026 03:20:29 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df349d8sm10350959eec.22.2026.06.06.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 03:20:28 -0700 (PDT)
Date: Sat, 6 Jun 2026 10:20:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 04/12] PCI: liveupdate: Document driver binding
 responsibilities
Message-ID: <aiP0Y_7dQWPpfS5H@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-5-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-5-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:02PM +0000, David Matlack wrote:
> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava praan@google.com

Thanks,
Praan
