Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36DA2494FE
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983689; cv=none; b=KFWlQa2t4q1A8nOq++DQpqGd07NPDHUJbcV+twU2JKdrN9byJXSkmVlHov0esUT5rTdKr6CKUR0E9o6Wmtnv1EvmsGnvESrIm5kOKI6S2sKK417zNfFvQB/nf+OMhUYkJjm6LHzJBMREkrkaOpiC8KZasrMzWg5OcuPO1Zwrg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983689; c=relaxed/simple;
	bh=HBEYlcIc7GnTW+YvomdTIW6EpchdhjkgOCxL0C09iL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+7SoyVFp900aucfwdZd4CRtyvjixU+vO78hRjqh/HUtt7P6LFZ5jSx6cz8AUyNJ2j09z1+l26NkbNzCVPd9TV54iuu7IUzbWwHaJ/BU6Y6a0wKQgmf8hInf2CQL7sJl++xt9D3ZLvxxwtgHSaw6Zgw6W9NcUnnO2WaTAJkuXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Yj7z40Lh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Yj7z40Lh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899aede64e8so4643576d6.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 17:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771983687; x=1772588487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6MLMChCRx+KMQSVhypR0LNDXIFTtxCcdGqYANLUR40=;
        b=Yj7z40Lh8YvvI0HY/SjXM+yzmUSthKZ2bWjOwb1BR8IXrZg7AJlCrGMsDp6OVa+6yi
         jwFc7mv1YXh/e+LzqoUiIbC+H6NMU2aFbChHXiJFNKLu7AFxJWGipaHlyB93maVAOsqQ
         Pg6XhYBTlfQGLonvWW6Ygy7R4o9JJyMy4SObpzo/kwLtwhR7hoT2iKYtrH9gOxq9zjKx
         XjxaV4HMlR9TS/c5RV41IbwswK6oOvsqVJji36wg6PaG9FjBlyMvgG/vtQIxwRVStDZw
         kpwfiOuKJMKGskDWqor7IsmSPBZkH9BdHd5mLEGgFktfesz+oszuQ56xRZQk7NM4FRHZ
         o+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771983687; x=1772588487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6MLMChCRx+KMQSVhypR0LNDXIFTtxCcdGqYANLUR40=;
        b=Ok3I13oX2JDP4OGA2Qax8YkR6HztGAMi0WNnUGRLHVdM7T+IRUaWd4X6gzNvyEJHiL
         2ZsS7A3K69qSWs4CN8xu+/4D8+Qw7Uo768IIhwPlG+yDTjHsywjYgzYXyadtj0cwG24d
         N2pSmIh/MZ6z/4SnZ98K0AfXtyemaxauQn//+47b8pFAv+BCvkJ21WxuhHc0rFoULiqq
         mbspFJ1zAmNBQJXEdW2uXat0q2sjA9iijA6ci0lOpki3SWt+B0pkMejRM8lmXC4FFSvI
         Kq4hcU2XKlqJ4fbBKZjxr+4SW31Ck2Vz6DF9Z6DujEyW28dAQc1mW2g073HllWAMmLYl
         JxQg==
X-Forwarded-Encrypted: i=1; AJvYcCV2RhKqBXAJe9MmDCleyr0MS9fyMxFwI4HCvl1C1GnH6atdbtdRkDhGiF5j1sjLbLxxqdUzLGjQX+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdSvqNW+Qm08zzwBcwqG7f33lArPahlrR8mbh9aG0qsi+kES4
	zFIqyjVwupSUGIqNqlS6UNIZ4WVodcPvbg9jqccmd84zmsPi7GClLoWtVDqvbSdlrS8=
X-Gm-Gg: ATEYQzxbluxagnkmhO0ZgU7q7ivUG5DKmDLbZP2+qJqRj16JktFhUJNUPTyJgBnVINQ
	9K1Sw6hSKOjnsCu8ShgPCwqtxRQSkn+4tqs9DWkjo962ybS3fOkHHCQbkaLYV8BEgw30NX123Fs
	dgbLdkBT1ikKCr6grjcobF4uy8MewK3FQYj5RGtiMau5ZdQHEFZh384tTq6TmMw1QC5loitGykV
	hEjlg3/N9/LguBJGv6yV00eDDGtX6atImpKNhOLA1RZz9mv0hf7+Cr8VJlo5EwKia1KoiF/5eNX
	OwLa+Tzgs9u8v3n3rBJMn/fAZcB/VQA9YQL2YsdPEhMTvvQoi7xl5lIBLLnyAK6u18rc141iBFQ
	nwSvYNvB/WLAG09w5QwcuMGC8p6zYFQcuTnZTaezSt5W96vwvAtlU9vCFdD6+EPD03euQqs9Ml5
	mql2PSae91ub4W+vdGseWzHPI9V7fL9Gf1Hnzd8AwWpq8tRAP6gHJZ34OAdwergCJT6A6sO6K31
	yKLPsWIljTmuzvmcavhTmCsz2jo3Bc/H4OtMKiOLLntfbichKY=
X-Received: by 2002:ad4:5f09:0:b0:895:46be:2983 with SMTP id 6a1803df08f44-899b34c5bafmr32547266d6.12.1771983686726;
        Tue, 24 Feb 2026 17:41:26 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-899a617f875sm30942756d6.40.2026.02.24.17.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 17:41:26 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: ahuang12@lenovo.com,
	alok.a.tiwari@oracle.com,
	ashishk@purestorage.com,
	bhelgaas@google.com,
	guojinhui.liam@bytedance.com,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jiwei.sun.bj@qq.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	sunjw10@lenovo.com
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
Date: Tue, 24 Feb 2026 18:41:19 -0700
Message-ID: <20260225014119.10047-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <alpine.DEB.2.21.2602231829500.46231@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2602231829500.46231@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Feb 2026 23:14:37 +0000, Maciej W. Rozycki wrote:
>  I argue that by applying this change the issues with NVMe hot-plug will 
> be sorted while keeping the configuration working that 
> pcie_failed_link_retrain() is needed for.  Win-win.

I don't think that what you are saying is true there is invariably going to be
some other consequence of this change.. Its hard to believe there can be any
changes to the pci drivers that won't break something.

>  I note that active links are unaffected, so to say it's meddling with the 
> link on every device is I think a bit of an overstatement, and reports of 
> issues are from a few people only...

There is no discrimination about which device it can be invoked on..
I'm looking at a fleet of millions of hot-plug'able devices.... I don't really
know if it matters how many people report an issue, I think what probably
matters is making the right change. Initially was there any other reports
of the quirk helping with other devices besides the delock 41433?

>  What outcome would you envisage had I taken the approach from this update 
> right away with the original change?  My only fault was I have no use(*) 
> for PCIe hot-plug and did not predict the impact there. 

What I'm seeing now is an overall confusion about whether a link failed to train
to gen 1 or was recovered by the quirk or recovered on its own etc... In my systems
I would prefer to NEVER invoke the quirk under any circumstances because I expect
my devices to work. With the quirk it becomes more unclear about what the cause
of a link issue might have been or whether it was even a real link issue in the
first place or some weird timing.. 

-Matt
