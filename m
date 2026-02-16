Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB0312834
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251719; cv=none; b=r48iZZpxWbFq3mqA4wIjFfNF6o1EXGaE8RYdVI8FwWg8tkskDPAqjzOv/AzukNces/opArnoB7uglsQkRxamJtWTzV3QEfVhndUqMfu/vF/faTamk2eSKuuP//SI9vn7cKC2OVAcuBvbbCGI/UDPyu9GWkBgeGRgNYikn/2UdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251719; c=relaxed/simple;
	bh=swRvlvPe5R/LjcGwpOyqg3vGK98nZUkf0KBb5iWx1pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjJzlOrsk7iuyGplmCQu2w636RSXpOWHQE/uALsQMQFRIFwjukgTGo4W7YefRvzhUzNg9w+EiRsysffp90TTuIGQ3zPi0/dMyIwQtrCg+UtB/JpqRw5jmnADEu8WmmnvSL7/jq8SjBFWAcPwfCFkFQ1NdPtVt24HS7j/EWdSNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z3qIIcWz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3qIIcWz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48378136adcso16163305e9.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 06:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771251716; x=1771856516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZG5d4AeEhK6Ekl6x66KHq/6RRjwI9BsPgGa3qMbbWPQ=;
        b=Z3qIIcWzxmE4w8S9n4xv/bxv9dSOYzAhNlqZ5kLfwVobaoTJT8itGtKk+Xaxu30iFH
         TL00mlV+/L98FK7k07YD0CyaLHSK61MH9MAbDa1oUvFaowkM2InC/VLYaCB/ElevvyMX
         Z8A+pjTKEi6AVYI8vSdqlpf24HubiH+nqBwvCXo/xiAkA10KPTpUDUMypUXItrnvt9Z1
         c6TW3kdlQLsk+cxfrqBttBWQCS/O+LY1W5mwC2+EcV/RQrErvH4osXBS9YOiIWN7PVEt
         KBhsB1QP+WevJpVhzj+ITKtDz9/2YIVIOY7VmEPPhf7xipWwmQhk76qibEUIIvj/LVD6
         rcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251716; x=1771856516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZG5d4AeEhK6Ekl6x66KHq/6RRjwI9BsPgGa3qMbbWPQ=;
        b=tC16uMYhfS3YOVFT2PxR8KAFRcKRsn7WuEXAeYOUocANZjIOHPR5cPAL3wdi9FOv28
         QYYhRGYDUKBeP1S39Kj06u5ohrGd1TCvI9qQUQJFvKd6epN6eO4CtnrLEhi/pu4Mvgwb
         t7Zsr8YHSCtE6cDap+Da5IS2JNxlw+QGj6VQClZbCkfr6NC6rjIP5s6XtbLRkJpMIT6s
         /nr4c8eraCQu7GlpfEUnL2LtawJjr9tdkPtvPgPIJrpuXakL6IA4AEuTM4t06eFAgrK7
         30Ql+A2BiYIpW4t74xNaalb4B5MqfdBy6u0LD4s3AkWOI+OnQ9ouv5BT4Xa2yErUl5Ws
         l4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWMYLIQpjhraIH8yA8bT6mjYXnp6ABYriVJ72x2ErXSLdq/4PYcK8TTYYpeANF3VvOs6XKccYnBil0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3q2sDPvAEnUOawJTYy1/gP3ot3LREvibZUujjeOn7IQeqSAmt
	mIzUcsduS/qHSMtGY5iA5drnbMAcu9Pc4nsuFRpdihpf4Qv0hUql5xVBk3MAkBm2JHw=
X-Gm-Gg: AZuq6aIB8SCw0hwmIzSfu94kgeaZQou5xeaUeDsAw9Dncd4Don6J0pE1J3Mt6pCNWDA
	PbhS4tBVP4Nt7/JUR+IL/BRtqsn3elmT2M///lK7VDyq58dqgzyceB3iiq4k/TOXKrxudYtqWNW
	V8TigdBhJ1GTTO7jvnH862WOUMCzh0++IHKE8g7TiXaqgmGCd+yJBkijXuNWZvgTr+yqpDwi67x
	ubCc3S65wqFp8RlvwrMSLSoBDBa4EvkccgKPILAREB0tiA6i4BJwoY1nC11pbgdZGf2rKxylbgA
	8xBCqC6EMk3Mj6P/T5xmUpkEFLlcgg88kQCUspa+a4DQB3hTcfvmjNcqkygkIWb0IMUoVmFs28/
	x3piBEZk8oojS3T26BvsJjgX1jLgJy3m0Sj26Ylma31e2Cajf02Fzsw64liR8FwmZpKp4PjEZW6
	YuY5L3nJA0dnGq78iXVyK7u+2qLSW0szb3+C+0GrF2l1/2
X-Received: by 2002:a05:600c:a08e:b0:483:129e:b573 with SMTP id 5b1f17b1804b1-4838dbb7237mr17621375e9.18.1771251716237;
        Mon, 16 Feb 2026 06:21:56 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a63afesm86717475e9.9.2026.02.16.06.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 06:21:55 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Feb 2026 15:21:48 +0100
Subject: [PATCH v4 4/9] pci: pwrctrl: generic: support for the
 UPD720201/UPD720202 USB 3.0 xHCI Host Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-4-802c82795431@linaro.org>
References: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-0-802c82795431@linaro.org>
In-Reply-To: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-0-802c82795431@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=782;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=swRvlvPe5R/LjcGwpOyqg3vGK98nZUkf0KBb5iWx1pI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpkyf86/3oKmTNhtXBfUIVltuEb7HAf6vq+eH2WHPn
 MaSqsSmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZMn/AAKCRB33NvayMhJ0aIuEA
 CHBlURac/cOv5Cakz3+K/ib4WO7qrQxbVbVopkK5TDOIA1TWK3JF8aWU88IDXBRdqP0xJH65xItdCC
 mefkwdSlYiT1pcSLIJPnyPqyknEPwUzscGv2LOLIa+StI+Etp15Z5L4+AtDDzRf11oTbR+YwyPIuZi
 Y3IW8KcdrgnzyPe3s/kyF1dkBoAxT6kDKNddnQ1Iebs7zHuAe8xjPNkznhFPu3arsUHRDtUSCuyDd1
 Cl8FGHTGU1/EfG0v8vpf0m60EPMQN2MBnogK1wiaoCG+7JHC3ZB//B1lxVBorXKhpa7DnPNf87C3YX
 YnH6si64RgSlVrk2jOCbx3w2QbbWP7CJyXFrSsS8ORqz0i60OfG/ZuMSQOsbYQGUeWRexLuLrSBaEh
 Jy3YjKxFuHRW/TUfXtX0xEMmOlc+js2eX/wzpbM4eRQtAIm6wzgMak59hLll6Tjd8aPtDFn/o/DqIN
 +XNdxx4gAlFv5hzo7F2nGv0xr/M33gzSPS0w8yNV9kyEo6vqNF8rKEPUZT2sltxsFXyCq3wXqyJ0j0
 bia2Aktfwjzc5YWJum/tiufCob9VS3NlHePyY+CPweLIk07GNtF/JoKm+vQHR7tiog3IFAWiUX5dLx
 pmTjNP28AgLTCQ8OyH8g8dtkvHSQ/QQleeYEsYonvUP1Qzhf8y3lIcT80E4g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the generic pwrctrl driver to control the power of the
PCIe UPD720201/UPD720202 USB 3.0 xHCI Host Controller.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pci/pwrctrl/generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index a5b7b7965f46..1afda639f0c4 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -73,6 +73,10 @@ static const struct of_device_id pci_pwrctrl_generic_of_match[] = {
 	{
 		.compatible = "pciclass,0604",
 	},
+	/* Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller */
+	{
+		.compatible = "pci1912,0014",
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pci_pwrctrl_generic_of_match);

-- 
2.34.1

