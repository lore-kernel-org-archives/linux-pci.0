Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842B4BD375;
	Wed, 14 Oct 2026 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983821; cv=none; b=P37d9pPP9kdsxcZ3dwR/bLPWSuWegQofcOBe3Z/lMvARtQw6ZRoMnD824PVe/zB/oaP0IluRnwnc7fMR5jO34lKPilqjXy/9AcJBI6Y3Q0a2ZcIfNoNtq+eeflYGhK7daAEMu8Mx4Ozf4UDcJa/fFeSXzpE+0Gw2WlxHtftahnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983821; c=relaxed/simple;
	bh=VYcih56GcFQ3e3VoLPRtwwV1oYNkHmwe8KWhuoWtck4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Miu9rt2X4pIfYR12OxrH3zJGjS0ipG6zraUl4so1IIH0DHJFZLEXN5AVFmo6B3dC7iv0D9xfzF8FfjoMy4Ef3MPt92fbDYoaOza8dPRerzylzqV/pCUO+N6uVoD/B7VeX/aASB0/6fF3UevZpHOemnxlI1tpeahZ6824MdP17pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVR30DuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVR30DuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E5B1F000FF;
	Wed, 14 Oct 2026 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983819;
	bh=7RwE6iZAmFDGTIXch29CA63d+n3O3gLHdWAV3PwRBxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HVR30DuP09bFfS4VqogcUMqXMV5xSAmbRqoFJgoK1eUL/tMYKOVvcjSWmDKPBeEsd
	 TVPXrHGcsNbvO81sfGqqcYgY2RBVYKohBr3DCa9Iq1/znqDPRzV31SlTGrh6SLJVuH
	 zL2Hw68UpOlys8abUuXX7uR1IR6p7Ek+fBkLo7j0FFNShr/332N69/aungm9KKS558
	 frWczwZQTvOWCSOTkwJ9/k+ih/+zFiBI4y7z0rs7NfN6EKOrGIDWPGOUtJpu2aJQ3p
	 HwomaTn1VxnDUsmuAHDVgxuNAWV9KOGo6/9Qw63dDwnr6G1RjO8yBWzCFZgNECnXza
	 YtcL6kZw3eaTQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan@eswincomputing.com, Pengpeng Hou <hppiscas@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 ningyu@eswincomputing.com, ouyanghui@eswincomputing.com, sef1548@gmail.com
In-Reply-To: <20260920033737.13957-1-hppiscas@163.com>
References: <20260920033737.13957-1-hppiscas@163.com>
Subject: Re: [PATCH v2] PCI: eswin: Publish the platform driver OF alias
Message-Id: <179198380992.63727.7418600499689326147.b4-ty@b4>
Date: Wed, 14 Oct 2026 18:46:49 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=319;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=VYcuol4MmAAiVhGL5CS+WtD9mnQVulCMGjCPHR5N+QE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz4DGwIv9MdYBuDidOIekkLfDsPYcUTdM1RUaL
 EcqJejTFjaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas+AxgAKCRBVnxHm/pHO
 9bN3CACCpe++dGTv3O5rpmaJNDgpXOCYZGI0pi5Q9JzS/lGlyfleQSB6+WboUXcH6ozWP1NI9KF
 9V1fisnVEsYf0IRt8IjoeIXmaFy2bJxJqpyKS/wapHVOZmlT2fpAYDs4zLNhn+oDOPx5OmRbbEn
 XbV1XVRfKh9akFB1cT+VhRQT8XQ2QhOxGUka/DzAbHQz8ty/vKDPjlptNXZzn5Yk3RIW0aMtzM0
 fMbh5AiHhY5wm2d1UJIm48ca4ay+e+vAt60+Tzsq0OWxY2+93pX/UtWFJBEeRFgX4P4Cy/dI7vf
 6o6kBAAemOUmlAX0bU8afy0IoWUDiJNoHfi/bcHQZlDPdPip
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Sun, 20 Sep 2026 11:37:37 +0800, Pengpeng Hou wrote:
> PCI: eswin: Publish the platform driver OF alias

Applied, thanks!

[1/1] PCI: eswin: Publish the platform driver OF alias
      commit: 8ef6cb2591df03affcd9fa683aaf05da3bf26f49

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


