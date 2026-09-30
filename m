Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690E151C35C
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784500; cv=none; b=hPQv5ACrwylJuTSBYmxnJEEKmpG4x9U1sqz2bEwQd9+MLbxfZqi8YwRqqnYrLRxjfPqqLo9XwnIPkrCZul06ZS7+b8YRbKqXUSB6aqgOekbAjcfRGfO0B4kJL/m0aZ/H9IaKyQ4XbCjGiSTJ4Zc2fDVW2i3uxirjclxGhYFqY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784500; c=relaxed/simple;
	bh=zJZKQMvC1ys529AS4mRwnIJQMZ7PXCRhjNH/GOfynAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dsTpgs4FXKpV55zqKbeTd3wDAd+puHr9dvywiPdqSY3BvjPs8efrfpndWr3X6Nb/ND5103n4xinLS93EpJ6lyXxE90J3VdWGSQ0LT/aSt28ErFWf15lNnkiyuHPHfp65lIoif6pnoHQEozJHdJW5pEHIDr9W13Q5OlSiRXistfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=FNDqE/Rt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="FNDqE/Rt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so51981195e9.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790784491; x=1791389291; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CaDDtrGWSBNMp7ldkJ9Mq01ee6XVOof6NPuczSuozcI=;
        b=FNDqE/Rt9EpyqxjjAgkkneVHs5m+zPEP3nFkAa1e8oL7Fg5e2RPlDPdSlRjBRdY0VW
         2l7u6NDfhVMTUerTWRbED00Hw6jT+eeZEe/v8nnqojy8GEiAqxki/PIvMY95L3FwtF7P
         O+g24iV3Ykz62BWxBywpCsxJ08Q/qwex78qFJ7bvV7Xc/oIF3P3usMpGhxEjiC23w7N3
         Ob5DndFEoFOigml68IYAP/tMTBqTTMtWJke1apltV1mzcJ24qoMlfGRdaeBFosofLZy6
         gYol2HFAfM/UGiuVMZS+pG2VnOWAazwtcQjRL1LZctuJRkpbQaTGtzA+uz4l98OqiIJU
         dEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784491; x=1791389291;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CaDDtrGWSBNMp7ldkJ9Mq01ee6XVOof6NPuczSuozcI=;
        b=2lfnApszmbJOFG0AhxzzAUkJE3Q2Ko2AngeN0DL8orovNr+BH9+rD1B8oe3PChrEXY
         SeQi6w3QsvzdJUTtZo0QcZHMFTdkDRqYJ3uVoqaVvGu2uCE/RgM4udSWbcyCxKgABz9M
         Gl1y22vX/Rla2UbK/sUK0bLzR0L69e5EfVi/G0JUhVcEo/KUbhqk2y5ohCueNRgDAfZP
         dEexJ0vvh94mgAaWuUHSUfaLQPD5BjWEh+ltxy1lmsH7BX1dUx7Yrcbej2lt6HyIS0MU
         uefFORS2dgsJwT4CY8EPfaTuQQ0j1P/ni1saeuotmHpxD28VPDSVRUfl0wtj+Vh5pRWs
         LNGw==
X-Gm-Message-State: AFuF++lUuinrV/K/uwqzbIVAIpes/Rfyjku4B+IC7XMWB+gVz051zGFe
	R54Iy4AuChqVTvnvoZB99UkqFFhN7M03X0uignSyqHryn1Dt4NrE3y1y7ZBjgIZ1biE=
X-Gm-Gg: AYBFou3MNIGSaHeJ13mQom/iWfXUHc6FLqNTIT8jPo10IT8dgeSGAX3VWAF5HNWmI48
	0mwM/aSmBmGxarZwhBRLCzYmrF+hXs4caPV+xSLvdiv3mS7y6dWhBueh129CuOM6d4SWdKvTI5g
	14+NIRsxZk3Qzdcr2Kd+zUFeFFTioovfMraURN1XK0iwRLOsxsk0f1nF0s9s3VdNc7j9cwcbryZ
	rc4T0RPz7sLbARBtg6EF7S/wbasIsA0xqPJ1QCzgDvmLNbjfhlh0ZNwrA/KTt5fWPXdoULIrVAV
	3v9ETiNkSwTS0SG/Ln+1fYVs2fS7zdB1ka++PoaMcu2tvym2029Kz4ByyF0bOfxFd8OwqsQSqbe
	xbCeZngJPAnivSJDXTmQlFch8OoM8azBnIBk578LUddGIwMCIhUHMLV8nmkTeHoVpRIW6ZeqI1d
	ckQxWMGNyj5Xt/ZDcn+0P8YR3+yx8vONEvxwkhpDfD3QleRXfLQ9smr0jdTFRmjtbCWY8R/e1oS
	KdQDuZK453hprJYQg==
X-Received: by 2002:a05:600d:82e3:b0:49f:fdca:c34d with SMTP id 5b1f17b1804b1-4a01aff3bc0mr40168695e9.8.1790784490851;
        Wed, 30 Sep 2026 09:08:10 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01eba0d3csm348905e9.6.2026.09.30.09.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:08:10 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 20:07:45 +0400
Subject: [PATCH] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-pci-pwrctrl-kfree-v1-1-f09bbffd8da3@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CIBBA0as0s3YSSiMtXsW4EBx0bFPJUG0Tw
 t2LunyL/zMkEqYEpyaD0IcTv+aK9tCAf1znOyHfqkErbZTtFEbPGFfxi0w4BiFCdxyMbvtusEp
 D7aJQ4O33PF/+Tm/3JL98R1DKDkzCjgN1AAAA
X-Change-ID: 20260930-pci-pwrctrl-kfree-b58621738902
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=alchark@flipper.net;
 h=from:subject:message-id; bh=zJZKQMvC1ys529AS4mRwnIJQMZ7PXCRhjNH/GOfynAs=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtNX65+WWP/Mfzu941zmZlS7rP0rEj86TahXffNCdct
 qgydQ+X7JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqozwZ/hdpzbU7EyD6oHZh0YndG81Kd2a+tfh76oxC1OuXned2LM5iZGh4ubL
 TVivZzuSjrV5I9WTHxGuTO2U7+rd7HtV6Xj5XnBsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumers array and hands it to
the caller, who is expected to free it at an appropriate time.
PCI pwrctrl never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Cc: stable@vger.kernel.org
Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Split out from [1] for easier application per Mark's feedback

[1] https://lore.kernel.org/all/20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net/
---
 drivers/pci/pwrctrl/generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index d56171e0ee24..4b6cbbb52248 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -63,6 +63,7 @@ static void devm_slot_pwrctrl_release(void *data)
 	struct slot_pwrctrl *slot = data;
 
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
+	kfree(slot->supplies);
 }
 
 static int slot_pwrctrl_probe(struct platform_device *pdev)

---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260930-pci-pwrctrl-kfree-b58621738902

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

