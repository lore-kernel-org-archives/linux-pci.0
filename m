Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F714A014D
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611706; cv=none; b=Ljg0DXXfuwkZecYNgnMaWWCTo2fexn62TlF7fGSMtH1rgW/kvRfATaqtCVaak+4Pt9+97jZNYO3SCDaKdu8ee5To/5TQYtbxqMvGxRC7xweIfgN2PcNOx9Un2Ng/y6CzrpjBXMapshnICtdDmGXrw6wF9QIHIC7nZ0l9k6V0ACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611706; c=relaxed/simple;
	bh=fqRQGN2NtOQEQ6U4DtETKEyMZbTPYavOTcCPLbSO1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GL7MqYbSIECJvI754U0kkfFdJOieBNbSPb8Ri8TeJrhyiInkXUYwd4D9eIobGB/eDdfFbSUq6fNV4deB8pR3WMSMf5F8gfTwHPLzvWaFqlRfiF8gryyE48KkDN1bdVxJ2Dvhm/tShdsphtDUiCOhTjKCbURuOF+85RkiGEb8lGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfFc8NvH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfFc8NvH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so2473817a91.2
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611700; x=1789216500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=KfFc8NvHycwffxp/MuDnnI6GzEu6tIHkW7Y9k8dKiMJfZJeskPB3P5q6k9dVF+jvmM
         Ydfr1SY5F1o8KsO693B+bapTI3AmcIOQ12mZdNgtxBsDzt+uI8iSj/szdJu6H07pswID
         u8iCSNqEj9vr68rZF+sv77X7kqqF5mgcH6wEp8ep1ZBshraYqUf6C7sX5GQFyCG6wSjl
         dfzPw+cDm9IQOLhTcptEpWKPK4shPYU1u3ooFNYAlUKrOtMEVQvSj2jq57ArrJsZdR65
         R3YTlfJcbI2egUYL501e7Etl32DKVwR7vi6VJxGAv2j+HB8slAKHeTVFYzsbD9isqzK1
         FW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611700; x=1789216500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=bXC2W3aPP7BWc56pnIOu9SpqTQ3XXPEUgN4RT9C5uC4T57SDQDy19Hwbupslokls+1
         Xk3ImUtdfHY/al8B7ounl+uqTQu+bsbVNrWOUEEKHTZukxX6bLhp6NyAGYDTlMg5qK51
         7pKfZcVry+fFcyP2X42FbpjTIToKpBES3rHVpZkBmUihC1y5KwMeUNllrd3/Xi8vseqm
         7xur5f1+RFcyHFCHjJkysdRA2WltNA+m8/RCwSmSPrGk8ecEoPHSvV0g1Se6YgZ8J5RJ
         o23r6pnUndPvj0PcrHJcuCm9P1/2WUid3PbFcQj+d9f1NXF90+ne1zhJLU7NGB3sp2gz
         2V6w==
X-Forwarded-Encrypted: i=1; AKwUvBxkCt/ik1WxIedvN3nAbi/+3zMWQDfHcvYE5g3HbOULhnoneRBghJBqIaWRoL23w4AOIntz9MLF/1I=@vger.kernel.org
X-Gm-Message-State: AFuF++kmQbzH+Y53kRyBxq0jbkvMsrn3XqA/rD6SNOU0xyCYhDwnf97i
	rkMg4O0plbsL6+SK7xNAURPZZIBdU/ZjwOdYhBMsV7+ovtz+GaYKgFLa
X-Gm-Gg: AYBFou0T0cy6NiR6ieze+7QA3ptx0Aqzqnqshg6oPWmV6cc03R2gyHO4pk5/rHA8I1m
	1orrJW8vV/FyupolcJ2KYYBYoeorukEpF9og9+4VJYowfeljBN/9OCBPwMhJVDTVQFsTMHnSckz
	g+k/6ui9MdPtAY0T500BHlyfVon+nHYrgjY5rfZZwgXwBHZKucKB3c0U1bN+qOcTFl07p4NcGoX
	jsMUMnfDzB3kDJQNa/QYVDAkcjW1vtwZFWz7KbYKLML4nGtfL33ggiAVItFXL/xN3ZXVLuPe3Xz
	OG8yR0oAqiKFNpoo90wrwJvF1Yl95cHPNoCuOEqMm6tSM/H7tFzi5V3Jhw5qXMNTI8IbrCXjNBj
	D0m5axuzDv3oTiMlI5mPPwy1/iyzgxuZ6k+vKDFS0fOKtt/9t33wSxbZEhPKNp+jDSpX9ujtAg6
	635AXWyHDPYpbzXwzHvlPKtYWJWsrIZAD1zrU4UeQozB1zsgq87iGOAtFtFEn/0nChy0pFLf++r
	1t+Da0jBYg5Pvjmd7gK2D6DPc+mx3Nu
X-Received: by 2002:a17:90b:17cf:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-39b26216cf7mr18508993a91.23.1788611699999;
        Sat, 05 Sep 2026 05:34:59 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm13829815eec.27.2026.09.05.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:34:59 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v6 2/4] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 09:34:48 -0300
Message-ID: <20260905123450.5620-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905123450.5620-1-breno3011alves@gmail.com>
References: <20260905123450.5620-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a Makefile typo that incorrectly placed the mt6316-regulator object
under the old CONFIG_REGULATOR_MT6315 configuration flag.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/regulator/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8..f81d1f31a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
-obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316)  += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
-- 
2.43.0

