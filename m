Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02031925BC;
	Sat, 17 Oct 2026 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213621; cv=none; b=NVZdA6KLo3unh3NdNoimHWkry+OKfOdGOY6CuMs8ULbylsdYgN829SrYXcsRVShKJiIxdmZ9fjdrT3Mu1kTjirujDS7hKNWfyazGvMYY6f26RUcJR8Uuho346gzWJ4owVLWKt5gcvv/R1JOys2q4nRrY+NjlaQKqlJxf5UQPilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213621; c=relaxed/simple;
	bh=6AibX6YCngIJcN/yXS5xOBZtVb3XeCfFM8NCLdf3Cr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qq3DkAEiL5S706CbDgRsxsXjXgdPJ5Rs4wvp5n2ac5xz/ALJWhB+djA+gETSlrNzD1YcH+NkY5Cc5DJbFdp9gP0TPhfaR3NZpeu/y2rep5NWSFfos7bajJFtd1jtZvHWC9BKZY52v2qz1NN7HIlnGyNIJXIyrNrBMlIVlPR/YuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIXuIoXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIXuIoXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99FF1F000C4;
	Sat, 17 Oct 2026 05:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792213620;
	bh=4UCDTeoeo6cYiyxMe9fYq1aH8U/k4xUlpfLtsbN67hA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EIXuIoXy3+29oJgMgyp8pD7E1RqhrdvTx66dg09UFZxu3s/lF9aLfGDZNGCa2SIF/
	 oxowfoZns3iT4cOk03+0TzbAIqvJgnhTELjWmgnPXr8oUwdtYNBAfAmefJSg/Zq/RO
	 oX6Oq5lwVWDP6vcZXmtuKSm8q0d0U9Zr+vJwJ6weNPcY8h1/1je4bFGIU2Lv5BefoM
	 kiYy0UcTAGlJnGXFuqr2PP2emuszSh1RF69p8Dzq8BD25ApyI0/XQ+aXRv2qYK3VJ0
	 9/07h1MunZMohHlmZmRm+vYyil2kI8jPGST8vA5xnptPNV+UMBUhuNqI/o1sbliX2Z
	 rlw6Pxg5Sx9Gg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 jingoohan1@gmail.com, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, a-garg7@ti.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260930013842.82476-1-18255117159@163.com>
References: <20260930013842.82476-1-18255117159@163.com>
Subject: Re: [PATCH] PCI: dwc: Describe DWC PCIe fields with full masks and
 FIELD_PREP()
Message-Id: <179221360235.2165.13933379659986541066.b4-ty@b4>
Date: Sat, 17 Oct 2026 10:36:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=355;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=UNjcYDt4Eez7Rct3x9msn07EXLMBl1+K916IzfnTGS8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq0wJvl8Ay+Jvq3whqz6n62/7yWs1n6YmtzzehT
 NrlkVwLT4GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatMCbwAKCRBVnxHm/pHO
 9esZB/4uBJ1bGH4foyQieZE9iqZAzSGWjWIBZARh/xU8s5PZ4QXB6YGXjOM3LWaJMy/wyd3KlrZ
 ZCu6QLuOyIoJkGyRfhYMC4YXZv5XGrvPEKn84LNNb+xlQl4u1KnujQAEjzH5v+BWXPEib0fQyy9
 9eXWgYqsv3V3CVFemFZ5/unQJYfaxh/caBobWBYyyp9QBWm69hfYGLmR3IHTd35Bik3H9a86Jb6
 vnKXe5FiOAT+KVPSH682SoZyusVs8EZWF/URsVUzhkyobvUOkap2R4UFr5QDc1fIB6YUZzlfmQs
 Db1o7u9H8G4KONLK06iQyyGk0DstR9dluFCDV2cAwpyCu8w6
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 30 Sep 2026 09:38:42 +0800, Hans Zhang wrote:
> PCI: dwc: Describe DWC PCIe fields with full masks and FIELD_PREP()

Applied, thanks!

[1/1] PCI: dwc: Describe DWC PCIe fields with full masks and FIELD_PREP()
      commit: 0bb385e6f5bc3f172097ec16392fc19493725c25

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


