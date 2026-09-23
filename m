Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D57E33B6D1
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126562; cv=none; b=GmFj+two8KXtOtN6D3+W0YGld+pPKOkGAg30Ql5bVuerzEnwruJI/ZSeEkpktskNxKPSwn+1I9pKtailVlIy6qky0TDa2jrYwiTg/wVkjeHVzIdKSkR+wSCiryazUS1roBwNfHqAxNlD/W/ecCmoWRCIgFp3pH3dfSxCWaNLCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126562; c=relaxed/simple;
	bh=+h/tQM1KRRz94YnwCuXVu511Yz+gseQKHqy43pFBzq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYW4OB4sjxYKjqobik3G2w9aaKhYfelkw60z+B6NjdX/Q6ugrtIG96FPtElMCdQkysBmj+W/xC2/DcyITbbBoqDcS3fydPZ57Cld1cNv8lll4nmgtjPZf/rD0CiGHSprfsoxDkoFlx2dM/KwalcXtY/GFZLj5Nw7ZkK5oxlitD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy921TE7; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy921TE7"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39e6298aa19so63090a91.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 18:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790126560; x=1790731360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+h/tQM1KRRz94YnwCuXVu511Yz+gseQKHqy43pFBzq4=;
        b=Wy921TE7G6KUWuVwkwRzZ16iM036rQS5E0LZMW4uXXGx77jeay2GOyMoEdKuuxoxHz
         QLh0PsoUevwrVZ32ehW1FrRHrXOtZzSRKwjo8wAKTBJ4us88RTPvboVeQv6LG01jHMoe
         xcYRPdV4AsSrPheo8RAYS9d2CVJX73KaEBrBLm6oLKj4pYAaA6SQS7Ognn3KxM8nzTQq
         E8dSg5V4QUnBFYJZ/0woKEjElYcSGXmLS0IVT6xh8y9vApOu369XbZe+aoK/bCZ72PW2
         twIPT1ugSPeslxSCFCAoZF6CJfruYKkTTnqzRpLpCytVdVuXtRt8F3oIKG1K8/AlQ+/j
         apNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790126560; x=1790731360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+h/tQM1KRRz94YnwCuXVu511Yz+gseQKHqy43pFBzq4=;
        b=udGSaMhgbQ+wfwq7I7r3neisDw/ug8uvRujtAEeTZU+85eksz7LjRzkH93wkLF8nRk
         4AnDsAZ/CwQv4m6Jru7vh1IJ8N58Pzc1VXlERKRUyYcx4EWiytauaHvrTgSBl/H9VF68
         nxQzIamqFofm0SetguB6pVOPGwXmt0VstbYY53/BP/9AoiVLekcmI7HHbbSswksiWHKv
         Q4ryCazQMOyFtTL+u6JF9FmenA0dTYBPw8pI83mS6qGMTrLE4RLoGsarpuLy3Fgd95pb
         mOv0ibyXE026Z/Z0E/p8o0ve0iuaHaXzaMZvXV4i+p4swDBG6OK/wmI6Zs3uYoPsSy8P
         iQuw==
X-Forwarded-Encrypted: i=1; AKwUvBxDccSH8M4qwEPjOUSW6XEFG9eS7N0S/RsHhSCfhhFR/EfDMBX+lIOhzii0g2tor3hkT03qIGxwJOI=@vger.kernel.org
X-Gm-Message-State: AFuF++l7Ej6MAd5rE8YpxlSY7p4/deWQzF5/WhEP6B1sZIEuCNCCBpCQ
	aIoBZ7CCXXHeuUDHZyjsJacwXOgVNrQnYhUK1oId0chhoIqs1jLCEISy
X-Gm-Gg: AYBFou3E6tCTid2C5bsS85zsodED5N3TtVI6gjlramKS1VHsCypO4iZmM2wARIkCiaA
	xuhvqCiYen1k99lrEio650E56ugFde6d8y16Tv10U0r4B0LUdQQNflfMeA06UJ5gKus8nwBQk0i
	beFPLIElm8ZpR5lodP+k0FgJZI/TzhThk/47+P0Z9c+7dfOVLyquvyMpzw9bFgEAQHu+sRVGoz7
	vnYaNXyzELOqt/VBhxLWFFp7ih5edCDcoujjDooVTDchksz/n6BAu/DTjqUe5pbXde6e3eGYScZ
	20GVS/CpJZb4V/lv9KL54dWwgs8neAM2smPod1dggNYK84y6yvZlBsb5fSfz1nw2cYYwOKvJHiV
	5Fy69UIahNc7kErwx8bviIFpof6R2gvPpnoCpmxRGw7kDHTo77xyM2EDb4f+XSj40Bki4UyMc44
	h5CdrbGN33IZjcFYSfTmqePHbQb6+Wt+o54riQb71fFFBbkM3WhwKJSW/L7Lvg5pJALZIyDpHBz
	NtlQM2R7giRRjaogUFJbfRElpjdGK4qGzWa5EVcH9QArSicbF6lT44poNfc+AGMwHE3yihm34jV
	IeHatztsW9H2QbSqGwEInJX+4T9UOA==
X-Received: by 2002:a17:90b:4fca:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3a07e773d26mr1573460a91.6.1790126560258;
        Tue, 22 Sep 2026 18:22:40 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de1f20bsm1784885a91.11.2026.09.22.18.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:22:39 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: nika@nikableh.moe
Cc: emmanuel.grumbach@intel.com,
	helgaas@kernel.org,
	miriam.rachel.korenblit@intel.com,
	mpearson-lenovo@squebb.ca,
	linux-wireless@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Disable D3cold on Intel BE200 Wi-Fi on Lenovo IdeaPad Pro 5 14IAH10
Date: Wed, 23 Sep 2026 06:52:32 +0530
Message-ID: <20260923012232.240305-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829093922.37103-1-navonjohnlukose@gmail.com>
References: <20260722021321.68902-1-nika@nikableh.moe> <20260729125202.33719-1-nika@nikableh.moe> <20260829093922.37103-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 29 Aug 2026 15:09:22 +0530, Navon John Lukose wrote:
> I will post two small iwlwifi patches for this as a separate series and
> link it here.

It grew to four patches and is at v3 now:
https://lore.kernel.org/all/cover.1789333511.git.navonjohnlukose@gmail.com/

Nika, if you can run it on the IdeaPad Pro 5 without your quirk, a
Tested-by from a second machine would help.

Navon
