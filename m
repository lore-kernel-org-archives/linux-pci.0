Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B93E9593
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334585; cv=none; b=LVkbDg4vqf6mkpwfbFvYSVJ0JDknxASw/VXZwejI47eN+Utydb5DOKnHZZcQCFIsREi99ZE6gT9mk4OaPKLwt4gA0UITkgBurjdEyJyAdVJ2K5BqZzRumbvMDGG8qAgg+/3SMzaqvJOAPXDVZWXa2qvpmW/g2E7jV55Rr6OwvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334585; c=relaxed/simple;
	bh=yu3nC6vhpzZez3hZu5WSDBz9l+V7URi8BT2ABBFXuP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcaphvWjIrrg+yRaV1KNqsE9aDtjtQA6U8nDXwZoahixqyMidTtCfUyEdVSyqQaEqVU8XdVMDI7xol7Y9z35lCVCocOYZTiExBCyFol1DvF85O4JFFJPa377Tq4TCek4ZTxsT6vyPYc4az3trRj8fylZv3aoBiEbwvtX4vZ51+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgBSwq0X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgBSwq0X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486b96760easo7970575e9.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774334572; x=1774939372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=BgBSwq0XGX55XxIPHkyReappFqNPHlYbS9wRox59BhY2ggelsZwG3qm3tAES+H8Wo6
         xUxtExLkAphLnNdwGId6ojdg6SNgtgBBoWu25lX0PL7BglUtngFLRhI/95DV+Dp8nYav
         Z1USzY0G8VLWMwimeg+bCFqrnrjOfYk99G9fxAxj9BqAF+lEuR/MRzxu6NXgpynfFwNm
         6X7KzIHSkh//xhBxNDrv1kroTDXtZUaMw3uhbGltsaCATeqsKT7VglrUHHUWpsi/vBAt
         QisqXy8QtY+5GTVDlCgt1n4pipKTAmbiCOXtOPi0V+8X3CDeK8CpNOVTc5Nsw5JmDM4S
         ZPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334572; x=1774939372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=Yzu6GshcNtg3Dyto2Sdpt/FnjNWIQuIU+uylPiUncGR9XECrFiliTBAkOmFDI0mAem
         sWfx/Br3+rzVjDDgOqC7R81yBlG3GzwEiIfoymGJu51WEMYfhP6tCFxvB5rkz3Qmmf+S
         MyWZCCfk5+BSFs63Je8oSiL3SPV5oby2ulkgXME+5iZBwa99COevX/R2En3xKFtoUDOM
         7baI7/avG7deS5ZuIUfDkuDAMtnf06jHwNSf5bl2d+3XGsL6j/nRsIS+D3VWQkupWran
         bppw5haenSTzKFT1DynqdyVme7/18O3esX9LVj6XkNz+bbEm53ujkNJuHJVCri3ynkDZ
         J/uw==
X-Forwarded-Encrypted: i=1; AJvYcCVAjJ/3nKt7A2OM5CA8fFgLfqk64lEYYr9uiTMVX7Qd7FEhy+luLMo9YZ0PAZqCCuC0U/H0Af1A+S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrS2sl55wFd5CKhEqVRe+oCg4BqZzyZUFxr2g/7nU3PW/0GANA
	AsDrnmQgwvBk75yMInZkJ6+Q8lDOSPzT0ZQJcGNbQTqyQvWeV9N+0CGuh3Jxcg==
X-Gm-Gg: ATEYQzx1KUFVm0IkdV9whk7l0s6cpLlf4ZmbLCAZ5kGvHLXJXYMQTRcG/c+4o5ktTgt
	VUkThwZur49NrTb8GG6Gh7wfmkPf6acHICh8sWAU6CtZtwyzp1mdhFLRNFQtOV+C62TjuSixjLr
	wRYDY6b+rxBYgTxRRI7axlebTX6QTgdKfBLDhMWy9EY2cdu84nue4IBnZSrEuwVyF6EubuHREDW
	7FMfTZ8b6WhdS1NWUkkfCKbibylUGCvgJ8qYUxQGe8tAOLtDf63xTiXKAPvgQkTWXu2v7uVusEG
	Kp0mPKQsUUwSP4OljRIOYJTXcvK529TLQRYYSniLIu8Umlk33F8viT6Xc7lDpyKHStTX+NC16dS
	pCF83NUAW5EI4fDgdjaq1cPIY+NFPgVcPSTmLXZlqTey8ftmwGBvtLZhimvBz5IwZ9MciMIU8tn
	BohtrazkmTTTb7UMHz9GU=
X-Received: by 2002:a05:600c:8b31:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-486fee304c4mr210200845e9.29.1774334572299;
        Mon, 23 Mar 2026 23:42:52 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48711116cbfsm10881105e9.35.2026.03.23.23.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 23:42:50 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: dmatlack@google.com
Cc: kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/24] vfio/pci: Base Live Update support for VFIO device files
Date: Tue, 24 Mar 2026 09:42:47 +0300
Message-ID: <20260324064247.3271583-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please, remove me from CC list in future versions of this patchset

-- 
Askar Safin
