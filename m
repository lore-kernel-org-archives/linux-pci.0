Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089775;
	b=ayZsObZM34prOcYZv0eziL6lyXh2YoevPV9ucu+PHJzRKvzMDdLEck7KBRClKxUIt3q3
	 +8p4VrriApxx6kq51/BR32kueKhlHz9L4arGWA4h94NsBtf7QG1lhSC2NZL4NbdlJgabC
	 ZZVXZNbcwVePrS63ySul6l/WHPAbi32yLdwLYtokJbluFp+FXRwiA6kHjrvdMDO4o0t/g
	 S0+ZxnJByo0fgic0Tcyu4+RQPGNmQmsIDjw6AKtZjSjVqsrAPzElXX8N/BB50wjtdzRYF
	 EB71OqbDvp76vFwVOgVX204rB9fGaaErE5n9xj1MT62SqFdELnJC8sb+ELsb2LCIjBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MGzHH13ZWFaAze8jomr5kn6NEKQkF5IKK+VbX0oc3KM=;
	b=nvijJuW02R6HZKufxo7cDx+oA7yaCaM9bptksFTWbdyfSHMLI2c3bNQqXM05yyGsNnqz
	 IYnJjF1k/ZS69qHo2R+CWxSuxq6bgKId4lj9YXWNjyljkPLmJQZxiuB0XO+S5NA5MRey3
	 pEsykXJKw+Lr3WFlGv0q+jdm5fvpuKRIlSLpBXdnTe/7g3S6CMOhMD30g+7azFvyt/lza
	 PBULcEt0KTCXK88eikaaeupUQuZO1Qghj2reAeTJknJshtn/1betQBW7n1CM+f82sQf7D
	 psPe09DRW7PG548mCsLsN5i2WjzVobhmxMdbSSXfXHWjuANpqV21uQoCpszBAApVRzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UfpuVEy5;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F8606A31D
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 08:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C56F8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UfpuVEy5
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35d0be18c71so904863eec.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089774; x=1793694574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGzHH13ZWFaAze8jomr5kn6NEKQkF5IKK+VbX0oc3KM=;
        b=UfpuVEy5veyu7vgwxb5ILNxC7fDxcHBEy9NAS0QZtpUfc9NKoNx9N92KGbm8ljPN5p
         6B4ZWPtqtXoCo4As62q9vysEjY1yGXImUkkdvr0rrv649HBeJLo5zIj/BQoDNws3rYwV
         kWGL6ZVM/cJN5Eyywyvsy2jQAwMqHdw4yV6r+xsST+4TLBkZTgU3GfFkJKgxumU3P8yQ
         2pdteBDfSYWRmIyfHkgdGY5MX+fKQ4/LvsGuN5l9iYg7iy9N9jcf4iRqT/iyx7WVoroJ
         ZRdJpYpMGgHIR7+pt8EMnM4UpfnFgcgwrJeHS7hUJaISQmYniNvrK4MZpzG6EYiiZxJ5
         Ce+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089774; x=1793694574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGzHH13ZWFaAze8jomr5kn6NEKQkF5IKK+VbX0oc3KM=;
        b=rXKokrngIPhLbGMhEJKlJhbHT0BiASkl5xvI8A4Rx1SADjJ13VRmKMS4yaWW+CY4M4
         8Ta680UUI2+5dZ4GRebYzJHHXl9faftDCPPII+TLHoegVUZrMzJMeHKzNGeqD3TX5iNt
         rCnZBSYXG64jOYEtwAJ5C2FQtWvbuMeFIaYpxCjhNJIPIC8CKzsrSJasz+noSkcTsQxL
         XUM197XwcbOBarYmOL8CJo+RYpT6f2py8wBy06Ah02NpQMopih02gOB3y6AwI7avLr2a
         F6SPg4mS0RgAG4PIlnHD6JfYMB2kTpi45PW8kAILjY97PSwCDf0bHM8NZxiuS5rfYABe
         PbEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLVR2z4J9qdn/I5dm17QlXS86f0Rdb7DGLriM2O5LaBPh+Dt5OFrUrS76RC0BitN1FU0sRc9EXJ4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfMyvrc5M6DiA5pdtoHdrc2EBiD04O52lQZFh/6jIGsMX3ZK3N
	CNCYluYY7yM9Eq1nPksdx1b1dLkRyF4RDUkTRLNfX3z1/XKKC6AX3DQ=
X-Gm-Gg: AYBFou3+goe6d3LqUHl9dNNAZYqOqupwrl+QwZ8jZU1tjJQe+M6dnBIFe4TSk044140
	fwECpd7ojPeCIETtIMa1UEuoyAnMXzWX17wnZ5ougxgylLXW1alArCME5bJklq5RuqI6JFcuO2n
	cdawDqZoprn2kknhNDyuIqiBlA6xQqRQ3IANpA2syCq4ZI8SfhBgbeIIhp9i1f2dWcFAnchwRrD
	r3JuIgZova0vxTnnVesw/Mf11SAIey9WIlEwmcVU+iVxvmFppjXorCeuNcKbBTLCeC+r7omolBA
	zfl7A6CU8udop6KOsD+XKBBOV8ePxngyyYd4iLgaxOoJ+wHNKq4eU8kkZdpwMNexaweA1w2pPSq
	fQ3cJApbSWQjvkNJaNYhuW8a4T8CzuD6R8i8JJWlj1MrLaoFGEdf3UwC89ooU/ckkfk9r/2b71O
	F7MHRvtGvxqfw6dginPjUtuA/HVEONop+nfOVp44OJE1xhmHCU7pDzGhq5tcq7q7/Pr3KtW9h3l
	7jkTVdZCyWJjSRyyWHq7nntT02kw0oB0excBl6/t0yYNEWvyIi4QmCAbhLhfzH1Jqh9eHB+PHno
	UBTqigArd2aE
X-Received: by 2002:a05:7022:eb51:10b0:144:eb3f:563a with SMTP id a92af1059eb24-1a3c84c3867mr2805885c88.15.1793089773456;
        Tue, 27 Oct 2026 01:29:33 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.26.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm43895151eec.19.2026.10.27.01.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:29:32 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	christian.koenig@amd.com,
	dave.hansen@linux.intel.com,
	dev@deq.rocks,
	dri-devel@lists.freedesktop.org,
	hansg@kernel.org,
	harry.wentland@amd.com,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	kenneth.feng@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mingo@redhat.com,
	platform-driver-x86@vger.kernel.org,
	simona@ffwll.ch,
	siqueira@igalia.com,
	sunpeng.li@amd.com,
	tglx@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps the GPU off
Date: Tue, 27 Oct 2026 04:29:13 -0400
Message-ID: <20261027082913.8002-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
References: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You can drop this.  Nothing about this is GMUX specific.

I agree, but there needs to be another variable. Using pm_runtime_suspended
or using any other pm function will not work, as amdgpu_pmops_runtime_resume
also requires hardware access and even though hardware is accessable by then
pm core will show that its runtime suspended.

