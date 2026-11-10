Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337090;
	b=gNnC2/afGGUIin0zWBfMQFabrYGixPrhhXplfa6MkoYSL87aoZ2/jrvJsgNbrH+65FlW
	 lsMwd3uq1As0deb/BpkmI/cNDyjON+iWGTXbE0aOMQCe1+1mXctFaTEkczgQtH/qDBEjH
	 uMftFmchKbPU+eyY6CJx6izEa8wgPYQ8ptOnatcSuOO7Ln+WsZo1XugrTqsaDQhUha+Si
	 PTcmMbj1ckVVW92lH+17DC1uXp2ymYUWp/asXdTyy2uMaxyeit5Kou7P+gQyAl6n3LLeH
	 5OFIRhKhiVV4X3PBMmOUErMJndy/biOTVZ39MRmp/B+hoCuooRGb+Ue/dXB/q3Pr52g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uax/a+Cf5PnYF3LAag3fOWDgi1ERLoTCpA7WArwoVB4=;
	b=w0IrET4ESMBYDx9bkgnzM1zfuCr20L4ayPbyNGRDkYZrOWYx18Y/hie7FYekX6PtFahs
	 puWCTS7rShtlv6Bj5E6Bswm4uk/Ojw33QmGCn+ol6dDWPsl2ueza98TL+QPtfYRVfzdFF
	 bnWIHy52LdzL31Q2H7LGejjndNmhVeQHSYZV5dPcB9lzhAk3zjEhlH54hsgRKFpB7AyhG
	 wJetQyAj4YG8wiUQoqnbEXtZ/jldbUTd/FrALevNdoPov1YHTTPo5cTQFDGxXVWXJkcqV
	 du0mjbLb34i7q4LFv/gQbpGcxFVJJ+XuVCN/8oBoz3AbjEijHJ3cZfpbwnGWtDlrt9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hC8j81W4;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380C60A260B
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 18:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4380C60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hC8j81W4
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f22a8515eso192374585a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337089; x=1794941889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uax/a+Cf5PnYF3LAag3fOWDgi1ERLoTCpA7WArwoVB4=;
        b=hC8j81W4XVy6GM6NSCd0k/bnKZL9dDfHbCnjIHZEMV4YCCxJo+rbG8Q2gJ1ziBpLGq
         b/WGl7uM+GbW0ScCbcGRV81gVeRTeNgz0MizF5kMHCM5ZPPdbitL1rbaLNattI6y9fcm
         0DpQSnY4WXKFOr6Wn7dT2dmcAELqKsJEKzR++vApSbK2g+bqtAQ3mQs5BCzW7QtRSntj
         GWWCQkNu74fERR+RfULkWg5huVt0eR7NbF0yCDO4S9QOY3TsdNE17R5IVmsDeMYlMoLP
         36wy31vJ31vDKQ9MKJyqWq+R6e/unEw5WoidBXKtWmZIODw2TxbkPGzvtWf17iNMm5uC
         b7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337089; x=1794941889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uax/a+Cf5PnYF3LAag3fOWDgi1ERLoTCpA7WArwoVB4=;
        b=goyFu4gfYDe55aqDA7CnSnGX7c0/xykb75+zlZLKGudKsEEgqLXFh/gkEMZmka69OD
         pAxd+jh15xLPQGgggSUXT/zy+mUG1voAf+ByJmtM/q2JMvlw3OzrxmHu0wWwVHJ8w4aE
         rplYWleH904WMTZXUL1FjIUbRudYDVhmuqFWk7NtMnHke2JVECRihBL+cQj1bBVlPNtx
         LjhR2lIaPWxnguzypDwlRNri/T4Z/XwHPCGV6cJQCMhZXk8c57te32OO3m32aXgNROSF
         RjUwgoLwx7HiLcuk2RFJOO8fDqSV1xcoiROsD6nYUbGPuX3SCLbjvI/0zt1IxcbqnGF6
         ebKQ==
X-Gm-Message-State: APuU4Z/0RoRT66HBe3K999qi+2aN+ZuodfUYkeKf4d2xAr08R6IFbmIz
	BSGbsvDp/tq1QujTvcgm+1P6FgAb3zdFPxyzR7jUPIzMzdc6UGvqCRss
X-Gm-Gg: AYBFou2lm5rzhKqnyyrCJRK1HESJ07KUdLBWhyODFP13RsUrGrnr6dcqxCh2NTURjRp
	ojcRuoRqyhdVMl2dntt/AAnUI712VfMJjy0R1Cj8kvYHbL+s6A/Zj2oRsfcQVn6Nz/l/Lr4Yccj
	Twp4Ms5CyMNvr6a7LYLucZN5rn5gi7JaAsIosPtliHQiYjSNZx9JHwzxtSEHBpzEXpRjdRRjb9W
	9KVcCPuuWL6PF3UBN27BTTEt9PgzOYnjFyIrAEVMGHbBwqZt+u9xOf4dMMStuoRAThR1gScuKZW
	gzs8omg/HYAK3nq+h/C7H4mO/MUS/fEAPWFR0c4S85JQfsY0pK+78B2re4j8PWweTp32Tm27r8m
	weq4XrfKehRCgJFuRnPM8EFuyYUTjBH5WHPxVtMaZmbHKn4nDqPe71OuJY7t6RmTJVLBhkngiKs
	ff91wWamPnQpxoHIxxAJWU6c1e9LHEZi6KSzq0AwYyYxIKoIF+AVNl33HyIp4h00X5E+1TjydbC
	0ZYH9kneDY+eDZScyhfgoeXXLIMNL/oVl9WCy4w50CYZT15KIaU0SxYjYc5x2X+v2OD6/BGCGTN
	qiKcRHVLM03giApzqzaY8WCP/y3moEB0v3ErHnsaMMfIt2vz4xHTA1rD35+DiWWTrnYDe8dlOJT
	+LV3dt+s+x8JsyjGdWxoNmH9eMRN8nHqLRlVNDGiXqnz6dEAFMYIncnPzR6aYKCtf/JR7u+LL/g
	aNe/tHcCWNdpCU83YD2auER35LhFzHe5Tr3rWOJaZKa90UuZyDiN2Yy9qGY57rhYw8ybaj8DI8J
	TTy1w96fX+aGVUR5MD9N8lUi9UktdFvk+eUQ1dg07WpcA==
X-Received: by 2002:a05:620a:4041:b0:93e:c12c:f127 with SMTP id af79cd13be357-9479f38d707mr575616785a.83.1794337089011;
        Tue, 10 Nov 2026 10:58:09 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net ([2600:4041:5024:4b00:940a:c6ea:f292:3644])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e619affsm290954085a.4.2026.11.10.10.58.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 10:58:08 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>
Subject: Re: [PATCH v7 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
Date: Tue, 10 Nov 2026 13:58:04 -0500
Message-ID: <20261110185804.56861-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
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

Tested on an ASUS Zenbook A16 (UX3607OA, X2 Elite), whose mainline DT
connects Bluetooth through the M.2 E connector (W_DISABLE2# on GPIO
116), with the QCC2072 support from [1] on top. Without this patch
hci_qca asks for a "bluetooth" pwrseq target the connector doesn't
provide, W_DISABLE2# stays asserted and reading the version times out
(-110). With it, W_DISABLE2# is released, setup completes and a phone
connects.

[1] https://lore.kernel.org/r/20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com

Tested-by: Jesse Casco <jesse.casco@gmail.com> # ASUS Zenbook A16 (UX3607OA)
