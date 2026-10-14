Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D64FECFB;
	Wed, 14 Oct 2026 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982353; cv=none; b=gRwitD7qpD1UeSfMp7l+E1bs5PwQPN93WP5MW1vzbN5j//sAoNTXbhywTvuIi1FE4vkSzncLJ1yeHXKt0psXtXhs+h41POAPEG/cgVh3d85GuLaVL26q9pIiY+jRqOcDJkC98x+4H8oEnCOlrrzAnWvOrX4flasFb66Jcd5g0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982353; c=relaxed/simple;
	bh=j/TF80xOVYgwP8HeOnF4JHrGvLKrytQUjZSJG/rAEp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tYDRJaodb20R4iQvKD/gqcet8SQnVIAgCA6p1WBo4xNoYoJij9VV1iSP8KWtUyPe4gS2skqh1u0Os/PwFksoRk/SmOg6/fq0OLu9jna12qeH9mRnUpXH8Ts3bJ1jfZTjzDHfqtwqsNTuXlBfxsB2dasW14Zi4VLeO5uG81WdTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrcYUc4C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrcYUc4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D04F1F00898;
	Wed, 14 Oct 2026 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982294;
	bh=lsdo6q7iGfLOVSHDjr9LDuzaBark/96QHxSKrnTPcqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JrcYUc4CodZD+eRz9ZFidXnb8vujaZPHvG+D1/0Y0HbfuQKsp+BMZKixbKac6HT+m
	 r0n5SKFFkj5nWx1GIkYaX6K7cdUzXtrEL5gEizpcAuN5E9chhD5n7DFBtVOm8P/796
	 GIkvwJNwMSL/AxJkBO9GtYDfduY1ip1WCn5EtujxthJuATHJ4H+8kXbEcmo68a4DvF
	 q8pwkPJUIeYcSgtmlDKtPcCSW4lVu3CkbTcmN9GWFgG9A9Z+e9yTiYGzpqIlf/yxO/
	 8CM1ZxYSLgbOtlJHYolHNIs3XT5CWrzUnz1jFYeM0N7ZuVxAQpwYer1A+C6W2KiZv7
	 ++igJ2rYREr4A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
References: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Ignore -ENODEV after Root Port reset
Message-Id: <179198228046.63727.14444543407304414177.b4-ty@b4>
Date: Wed, 14 Oct 2026 18:21:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=318;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=xYIEFRWgAJP3WnnePlvTxvJ0Twen2FCrrbpkfILHtgU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz3rN2xNylYKOd1knRNRodV+kc0idLKNOHCgt5
 OuHTgCOd92JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas96zQAKCRBVnxHm/pHO
 9eQsB/94/nEaSIbArTJme58EGB46tlfXsuh5k7tjI2uMmTU3ftORFYp6rRkf+uV1xpTFmfRkY7o
 A3sIbFZQuZaDIgkz+rhP6C3cEcv1I4Iq2/2CecVjuKBCwBDnAGrt+8WTK/8uli6KeG6fy+lVNb7
 cVSgpiAAc88733rsPvJmaK1uh4/aPIY7fRexGfRJdIOtpP2w29l8YT8MFwUu6sWI8NM4etgxXdN
 iV76qb3GxvqRBzGlS+6YQQl46qKUOVPyUsrbp7Ud7Eg4BafEMg4eJmpXaMLShqDOYnGcvrUmOTE
 Yb0HaPQGece4ErOHyeb18IOCMLLkjsnjowp10TYdxyLmFJsP
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 16 Sep 2026 14:37:49 +0200, Konrad Dybcio wrote:
> PCI: qcom: Ignore -ENODEV after Root Port reset

Applied, thanks!

[1/1] PCI: qcom: Ignore -ENODEV after Root Port reset
      commit: 78f27ea27d9870806f51b6f44db7ef6df62f7891

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


