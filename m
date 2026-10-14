Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC94EB867;
	Wed, 14 Oct 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982416; cv=none; b=I7shW2hZeqqOFR3nkbCuqTuY0tNrqWlxwkg8E6zfJOx9vf+On7bPvxyIpU5PJyTmwqzPNMPSgr0Qmvpyqzbkp7qB48eq+/fXnuYIR3RV+h3bTOXmx5F2aXe1W+14ULmf4ICPPSN394lhn8Z37G550xOShQAyV1ALSR4aa/UZROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982416; c=relaxed/simple;
	bh=eoMK1eSx4TJIAPCo1ybO1vVsJOurRWdkZh5vzifCi5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ulgd0kXHfckAx+PPPL7X2oiAYSjMbUoQpjWokkvksEyN2lFKzN8ceOlFSXl2yiwKrD1MN5iViUUAqn2HfHOXkQrChmYiS71KQWkcQuyYvTF25VMC5W/KtIDAD5q0DCY9CtSKpL6naIUu/PkZaZDdwZN16hCCt1s/6t/b8C1xrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCjaGPzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCjaGPzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCE61F00893;
	Wed, 14 Oct 2026 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982389;
	bh=jDT2IFdLA0AhV0qlErCAnYfvnnzPaGbbjaPIVQ+yjTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VCjaGPzpf3DHcN+K6gpqP8SaQaPPn0uKKZ75YU7rUNJHPufg/aWpGB8N+BzngOEcV
	 vgD2/3EdiLgqOznc+QyLBN2D1KfFmCoYAXa11lEbZ2Lq3QKqQz75NGzanqi9hb2bIS
	 fzb02m8sAEZMfjl3Slv3pDCJUsgunAxGLYvWgLeYJfEr10rk7eWZK0QoYN7+uros7t
	 JGqX+qPgqDS5a2QmxTGNGQHQzpfdGwZA+stsQqfFnILH6do8C0SH/C9tOIcFyx8GqI
	 2tlWjq41QqrrBeNeblv4PhROcohNk7TScSh8Yoo82RRYoIorBU3iAdt96WwfKWPhD9
	 pY/2Mk9lMuFZg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Ayiluri Naga Rashmi <ayiluri.rashmi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>, 
 Rama Krishna <rama.krishna@oss.qualcomm.com>, 
 Nitesh Gupta <nitesh.gupta@oss.qualcomm.com>
In-Reply-To: <20260917-skipmsi_forlpi-v1-1-14a4932a4311@oss.qualcomm.com>
References: <20260917-skipmsi_forlpi-v1-1-14a4932a4311@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Skip DWC MSI host initialization when
 msi-map is present
Message-Id: <179198237916.63727.13300930430351546653.b4-ty@b4>
Date: Wed, 14 Oct 2026 18:22:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=364;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=8ehoxGKFUmcfRUYVY7S9kKOZbczv0mIlzhFcl5EcS18=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz3svA/LMAcRKbqMo0UtQM9ocQDxznymMHM4oI
 Xi5R/kK7VCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas97LwAKCRBVnxHm/pHO
 9TuXB/0dOPbeYa2/U7QmJPIw4LjbhMHIsy44tCWqn4E8iMu20WGOAIV4yk8XUx1J9UfQgOrRDTW
 4d1EaPQ5gkdFJRwbmDmE5/4iRLP2h03REt9Wk/sfOdm0GCnvWtFAb96IToNEThqnN9ouP3Pd8+/
 c4xSsBNgDi7XxFN66zolKpeuca+bp7Au/ip7vd+pR3lozBe5mAfbp7xIhRZOF12bkRIDVk8oEs2
 /ZUlzeoOeZReOctFNMoPQmf4dBaca7xro9VLTEPK/NRaGfWXJhBB281WzMowVg4y6+Bd87EwRqe
 lAnyTz0+BtoypkTpBBwWC77UKs9n4V++7/SjVMER9l/lZSbt
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Thu, 17 Sep 2026 16:43:28 +0530, Ayiluri Naga Rashmi wrote:
> PCI: qcom: Skip DWC MSI host initialization when msi-map is present

Applied, thanks!

[1/1] PCI: qcom: Skip DWC MSI host initialization when msi-map is present
      commit: b41d4c09797a626a555f333c13df5bfaf8e7ebb2

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


