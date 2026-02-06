Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B2421EF2
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389444; cv=none; b=TnXHzg+zKqhzh1hFVPEORWzHFtbUFk/dnuGV3ai1JWtNW5GQyAcPh7Buel0HhwVWgq1o+kOXb3Y3ZxPv4HMcTUfnP1FV9VJ//4IK+swKJIz78WSq+LhKVk+G5HAL2XEgwtKexpBZoXA3XpD2+p6SF1q+10BBnSXR3luGTDHOlo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389444; c=relaxed/simple;
	bh=4+PpkEvLVppBd9AStXNzeyj47I1zwulcWEqE+HFfUW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKaHCSj3qw1YwNsNZQPFM9J+mSaoCu8oLnXvQYLd5rmyn78UKchm4kNUQx8CozlebBDQL+JERBgTrP9Gjo4HBwu4G0U8PDd498WCnYWCbFm6CZQNe1RSOHq9TiUyUuHu52eCZ6tBxBAELXEHF+eFVoaapIuZk8+cTaCzs3np9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EjwNNDEB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjwNNDEB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so7239395e9.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770389442; x=1770994242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6ZulV8DKnWt3EyGwh9rVroKMQ2zfFhCEaYa/TnkFaA=;
        b=EjwNNDEBrrKSyjdg178gf0CV7JDaH01NHlFgqVuX7+G/2Rewnzem8vNuN9BAszuq7/
         h0grdjbqPkmycLvqYy/wnA9pyi6GJhP4iXs91sFjD90wxrcl6uVQ6RWoJZgAuWOPNHPp
         qt6oVX5gAA8dtPwyRGCEKglWqWHUWC3/CRrpFFMqtSda4IbPy2FeMw1oiJw9I+h7WL4P
         +BopJ4rXC33+lnEa6/SWIkFCp/lqttilYhp4L/pzOVLjmQM1qz/UOQ/UIj3p9wjjNM7v
         PI4+iFnoTSuc6+1ZS347azDynRAJbq+LlwKqbkNAGWd/+sODjvUSY+xHCJXlW9whYJzJ
         uJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389442; x=1770994242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q6ZulV8DKnWt3EyGwh9rVroKMQ2zfFhCEaYa/TnkFaA=;
        b=AaU80+J/EqEBF9UIajOHgIQYvPiZfKdvhYL1hwR5TZsOhzG17jTwjcQHaeYEOX43pd
         ytszLZNSPx3X2eDqi3hRO6Y80++OYRmxnWzUWZIgzpCzK0BI/LM46oWzWVbIzWb1lfHN
         gFmmtCkS6/ioXkYNBKRSLr/pYI8+qBvAeMJbgaFtnAiCXzhyp4phW/iLO81qb0HQmzNj
         /4gV9mIlIStvj1gi+fiOiw6M0x48myOdAq1cevPvTRKAOi9rSpka+BkaXFM1V157U4ye
         rOb5W04Hr9IxpMbTIcdvLHkqta2uwiK4fklKMZ0dlS3rvzmoJ67U/vQVbkcf/unogXUw
         hGLA==
X-Forwarded-Encrypted: i=1; AJvYcCUMSFuP1amIlDopXLCdvLPMXfIDgVCgCd03qR2OgKLloJH11bwTsxynt3z8WkkCVX5dBG39wgi4Pkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAjYFAMspQDCPzfStXM0iMDiiCgMxXB7ENm0/2ivxLHSgJOdOj
	NJK8c7ltVPQl/qZ4fcltbr7XKcOQ3voAHbMaD2RpH4jztSfdaAubDOy5EKtPpAFuiXs=
X-Gm-Gg: AZuq6aLOVxGzTXAu7E5WTmJen2HXqzuBK2b6VgMtBRKFRFqD3ZQ7XUEGYDpiY5I2dBc
	5YxQUPYR5p9iIvdh35OMPQLH6nOse48YBubsia+MZ54qxYRwrERIUZC1nIpS0f+V8MTkHML5r7S
	N9pdVuqJoB7RzOj6W2/7vmuB+5r/FJxkrwIlpXMc57/+cikAPfdMPIGeMjhEsfBKdZp2DzpskLX
	L9QH30blynk5nw3XOWYxHjtyp9fLJxc35k0evQYUdtPt6kMnt6XSIOJxwKwqjstVd1DaMLK/03k
	x0WPYVj3ovDyVQvFTWQHwSSlHGi7DEOpeQ08aFPJVhY105MOG5HY3osnfw60RVO5fLaCtcVfxNA
	D/3ubOpe9YAWwiHr0GtR00xCYn0bBg5lbOxh2y+kZ0/qQ8QP/Smlk80NMuH4xGI6MuJq57oMU38
	5ZAbkd08P+MU8AofvQ5HGgud+4laZSKeB2
X-Received: by 2002:a05:600c:524a:b0:47a:94fc:d057 with SMTP id 5b1f17b1804b1-483201da912mr43057215e9.2.1770389442285;
        Fri, 06 Feb 2026 06:50:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832a38425asm3825805e9.7.2026.02.06.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:50:41 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 06 Feb 2026 15:50:31 +0100
Subject: [PATCH v3 3/9] pci: pwrctrl: rename pci-pwrctrl-slot as generic
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-3-5b79c5d61a03@linaro.org>
References: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
In-Reply-To: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4+PpkEvLVppBd9AStXNzeyj47I1zwulcWEqE+HFfUW8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBphf+7ocCG2ZjDcT8cW5NLfgp2ZrgwZ4re/8MlPEy+
 c8vWDU2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaYX/uwAKCRB33NvayMhJ0a5IEA
 DGRiJWHJEvqohf/fG+dsJZloy1MSYYe+hZVPyJqK23mr6VDpwsiJHQL+QAbJFV5d7d+aONZ/RFn+7t
 vhZV6zK1gZMbGGLH8lC+j3BQK+R5WoYxUPcm6RhjjEeoPHLPj/JP0zxedFbX6L/MUMwVwKO5Eg1R5v
 xgZXb394v3MBaqN+g5QLWk3WryeefOdiy6a3oEPjMvAsOesnkh4NpMuBopsDUlMjZn/igHkD5FMOqA
 gwXF6GVV3yt5yrEEY48EHKkeW+KvTE/6Ez6zaqHmye1I6IsRL8Es0fbZMQ8uBFWPvjmuyjr8UqgXFJ
 C3OT3KKB8HVDGIAME9ORRYnYE8H4JsrCgeYENEuS28GpHhmNXhVSQxpt1cmZAgRD3B4Zu6BA7ZWVdf
 MeKcpp/MflV4WL+ERiDYEZA5OLWZdsNgc0AsARDGABgZ54jSsX28hHcpQvKiiojPjyZzOK1NBuAetO
 7tU4lwa3xeAJD4gNRhIFEkyggPJEGQXMtqsQcYYTh9xQkvVkVefp2WN+eWaSs5le9cYma2f2P5XuLz
 Eyge+KwAnGLokcLolQwdHEGJVQU739qKWn1P0tg7tafLJvdLyp1egOUSsCw66rXpB8eE2mBhOJq/DZ
 UkF6JsgUDbm6yQgf08c9NkBHSUIy/jNydTyB2ra1CepS0cwPOXYR5mT4VLnw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The driver is pretty generic and would fit for either
PCI Slots or PCI devices connected to PCI ports, so rename
the driver and module as pci-pwrctrl-generic.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pci/pwrctrl/Kconfig               | 8 ++++----
 drivers/pci/pwrctrl/Makefile              | 4 ++--
 drivers/pci/pwrctrl/{slot.c => generic.c} | 0
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index e0f999f299bb..0a93ac4cd11b 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -11,12 +11,12 @@ config PCI_PWRCTRL_PWRSEQ
 	select POWER_SEQUENCING
 	select PCI_PWRCTRL
 
-config PCI_PWRCTRL_SLOT
-	tristate "PCI Power Control driver for PCI slots"
+config PCI_PWRCTRL_GENERIC
+	tristate "Generic PCI Power Control driver for PCI slots"
 	select PCI_PWRCTRL
 	help
-	  Say Y here to enable the PCI Power Control driver to control the power
-	  state of PCI slots.
+	  Say Y here to enable the generic PCI Power Control driver to control
+	  the power state of PCI slots.
 
 	  This is a generic driver that controls the power state of different
 	  PCI slots. The voltage regulators powering the rails of the PCI slots
diff --git a/drivers/pci/pwrctrl/Makefile b/drivers/pci/pwrctrl/Makefile
index 13b02282106c..f6bb4fb9a410 100644
--- a/drivers/pci/pwrctrl/Makefile
+++ b/drivers/pci/pwrctrl/Makefile
@@ -5,7 +5,7 @@ pci-pwrctrl-core-y			:= core.o
 
 obj-$(CONFIG_PCI_PWRCTRL_PWRSEQ)	+= pci-pwrctrl-pwrseq.o
 
-obj-$(CONFIG_PCI_PWRCTRL_SLOT)		+= pci-pwrctrl-slot.o
-pci-pwrctrl-slot-y			:= slot.o
+obj-$(CONFIG_PCI_PWRCTRL_GENERIC)	+= pci-pwrctrl-generic.o
+pci-pwrctrl-generic-y			:= generic.o
 
 obj-$(CONFIG_PCI_PWRCTRL_TC9563)	+= pci-pwrctrl-tc9563.o
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/generic.c
similarity index 100%
rename from drivers/pci/pwrctrl/slot.c
rename to drivers/pci/pwrctrl/generic.c

-- 
2.34.1

