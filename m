Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15E381E8C
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334084; cv=none; b=t57UX1GKWlYmhnXDqNwszbR3/wNTCGRZPGYsTHByfz+bWIioNCxz3GJ21eXejvX99Ea85LfXHaSudW80Uz5o2koB/ItmczsgNAbW6qJd7qeF9KHkwdV7FZFSfww1BsadBsR7kKHo055XmALzL4Td8dgD/r+038x6LzHndWNZcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334084; c=relaxed/simple;
	bh=RYuywvqdjTiryWx0HZMQXcmBWyUUadoRXwkVxaTdKoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPAYStChXKZEvUimc2ux1RIK+BoOwQjnyjdaro3+IUyYzbANwDbdT1JH4Ljt+iNf9h6/j1Pi4A4BdSnu0Ws/GZNwOxIppd3EHVUopHNq1LgokcScp8f3PPYIQgRKfH4AY5oBIExiV+BDCKFf6yl+j6jb/I1rDb79pFZNNTeNRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5QRQrxj; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5QRQrxj"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39d67a9ae5bso313429a91.0
        for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789334082; x=1789938882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=keGOAuFWtk7eVvvyNyqZYN9zhPLoleoThR6yxbotHPY=;
        b=r5QRQrxjQlldyKYYQjyCWVKVir8Xd/FKtbgNcRWheFkG3pyyRKpPEkVKfIrQUjXRKo
         pWgRqOaSoVl6cTEdptFOmBdhGFqv6IzxQi8HNXLFnQn44hbkY2WS++Wv5wumLOunNzIZ
         nT/Vp50zfIElETcpgyghrYO6kqTfuEdrFrn5Uz9gcvFrN4+FjySshrT5acUgAmVbWuO9
         eceH+gN2EICREwqMxD+8WS2WTAa0ml+ASJORW2dzQVidLi1EJJ+7ymr3cCdErDOxwDMl
         gSFqT8LsGokh570emrIhmDGPObZfsRR1PPbLetCHwAvxbtz+zvVyXaLEsx+ZLq3IOled
         vtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789334082; x=1789938882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=keGOAuFWtk7eVvvyNyqZYN9zhPLoleoThR6yxbotHPY=;
        b=PGA7z/V60DOpkGPqhpdnRo1p8cT1VnubhkH3hNacwVcZ+r94wtEm0w4SpoBE4CHbbO
         e7sd+MByR+ZmsVau8ixas7tLqLhPtiSadYEcyO74X7RB3BoSPxLREA3ebR16NMfeMBhn
         3QMulbK3fzylQ/FkRCTyvCJtT9tnWNiZSbWA2H8Mb31rKw5wlDk3BF70jgGazTVOmvaT
         MHneLIiGUzDYQA9uykoHMiouuY8yuv7Ox5B2R9Im1QC5c+of0bodJKr97q5oCXv+zGXx
         iPYbHDXjj49IAfYaU8nfwridqvNPNMpPyDlPcoN5r5eIv+vE1LT5HlzJt+1EFMlJZH1b
         WS3g==
X-Forwarded-Encrypted: i=1; AKwUvBzRasZnmlRs/FzXMnfB4VZ6B148EZcOVS1H7ULkIhPngXqXC8Aa3aYM97MKWSyIjCl7zYsQP8+Au2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kph0i1JEmkD9TN0qJTRxYDfy8Ym+djkltJUDVJwMDqsvJm7Bcj
	aoUfBQP6YfnbH1qsQTldialbsw3w7SuCvaAT7tXk/GqPLJpeqBPUvel3
X-Gm-Gg: AYBFou32nS1/90c/n0fIhekwcob2WqMj2BO9D34PoPgIrmftSvwgZVjKXuUZHHO9VE6
	i08IW/NGIsUmVwgBA3SdJA3g0EXfbvMX5fL5AlJv0aGrNIj5z/6yB9SedTTD49F3MIEeYNGI+Iv
	K0YqOUTdZqaFAQyTzhwPBq7/nNqqFtKa+7Rsw67Be6oDjfeqvzvvVToYvKxPHT4yK/uG/9DFopq
	T+ICttV/xPGG6jWU/bHXUINzGbSz/HkCq6aMt/tlLlLGvJVEUF3TvKaB+i6jClsHLKKNeyqJOY/
	xlNXT2F4NDl6dpz3C1v7zg+LV0EplAtFhady8KKpL6cH0krgeAcVYlUuOFLjb2j+Nh6sBIqbGha
	y7VxhHum54lX9csmNZj9OlOEdxTrxa9FPupsS4eRBVsdM5IS1HvqOwfUsEQ9Wji50atnY4gK1Hq
	NIrRdp7tcefoU0M0mdXSneX+2AhIgtDyJ2rQkegN567BzSrrofgYOlEkPTSMrpmaqbPzj9cDKse
	Yev4nvOOtni4CZOhx2sq1Id/VY+ohSQY4ydMqV5qSXSWwtOTqIkk1uffLz0RlXsd9AdmneBqO75
	fcEHf/GB4B3mbnANQ170
X-Received: by 2002:a17:90b:588d:b0:398:bac0:238d with SMTP id 98e67ed59e1d1-39d9c362f8dmr16743869a91.5.1789334082514;
        Sun, 13 Sep 2026 14:14:42 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm21382925c88.3.2026.09.13.14.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:14:40 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	emmanuel.grumbach@intel.com,
	nika@nikableh.moe,
	mpearson-lenovo@squebb.ca,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v3 1/4] wifi: iwlwifi: pcie: cancel the ME recheck work on probe failure
Date: Mon, 14 Sep 2026 02:44:25 +0530
Message-ID: <856bd0ddb7f3391aec28e6af710edb077204076c.1789333511.git.navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789333511.git.navonjohnlukose@gmail.com>
References: <cover.1789333511.git.navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iwl_pcie_check_me_status() schedules me_recheck_wk a second later. If
iwl_drv_start() then fails, the probe error path frees the trans without
cancelling it and the callback runs on freed memory.
iwl_pcie_gen1_2_remove() already cancels it; do the same here.

Sashiko's review of v2 1/3 pointed this out.

Cc: stable@vger.kernel.org
Fixes: 41fff83fe6cd ("wifi: iwlwifi: pcie: check for WiAMT/CSME presence")
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 28b276c..a30854d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4369,6 +4369,8 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 
 	if (IS_ERR(iwl_trans->drv)) {
 		ret = PTR_ERR(iwl_trans->drv);
+		/* iwl_pcie_check_me_status() may have armed this */
+		cancel_delayed_work_sync(&trans_pcie->me_recheck_wk);
 		goto out_free_trans;
 	}
 
