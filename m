Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069F54779;
	Sat, 17 Oct 2026 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213742; cv=none; b=fYI36VBVR8rLSygdi9oirp00c5bRgCFE4yEkE3/q8gvL8NRBz1kOJXKOzvDsId7wec5tgBN1gUJfmD2HbQpd0w3f8PjYGCLn9JOiJ2g5q9Xk2W7m7djKLBGxhsm1EUhv8PfT+/nkgbKRzEOaT+ETrCxSVGJUFno7liSQIvQPcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213742; c=relaxed/simple;
	bh=vZv+Ro9EQ0X12Hk9/RCKZdSioF9jiUv/82bIyb8JecE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gfbhihiT7wyDTyE0PSVNf8J1WlsYHQO649OW+rSnnIPhi17U65EJgFbcul01qd1O+2SMOM0Oc1/3JRg7n3HG4YGgnzHyCq4P/wgjmMzcEOHUlzvDOb/fjpGUIp7P4h9s/WL9vmSXsUpcqTOE6/ZZY2TVduFXVebXbyd+Mjr2ZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKPNl1sG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKPNl1sG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DAA1F000C4;
	Sat, 17 Oct 2026 05:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792213741;
	bh=Hh8hgD59KprNFJkvgmXCpyZWPiqSOLgY15L6h/7HzLA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jKPNl1sGsxImQq2F3SeiRgrwZW+GJfqrwyxOmuUueci1xB5nwcAsKHH8IeJ76mM0O
	 p3FGeXwj1YfOkSisRL/lm+K+fi8wJhVQ2Tku0eoJYkNt+DP4nf39RpYBf15xhLSqtb
	 241r9AbW7vztt2B1pBQQvStAs7PaHqSg1+kaZ5G3QH8hFsH9NzYPmjoSTqGa9ofc7r
	 qgKPmhlZ514CrvEbppdj47ZHvVe8wMuk55FyZrkTWyC+IAzTTCnLMWalj6c44rJgBc
	 PebcoglSrldkG0rF97tmEHGQqiaCR5GbdIf8TuMDBg6nRyZaTJoMX66mz3kweh/up8
	 KPXB4+xLcS+Kw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Koichiro Den <den@valinux.co.jp>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org>
References: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v5] PCI: rcar-gen4: Add missing PM ops
Message-Id: <179221371910.2165.3746961034244609363.b4-ty@b4>
Date: Sat, 17 Oct 2026 10:38:39 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=290;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=whg7raKWx1MyK1hn64e3xthGduvL5ZgiriJX/vpwxx4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq0wLlgvsPQYj1hFg0yZ6C4j5HxNk9G697I0zAc
 jBo17h2e9+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatMC5QAKCRBVnxHm/pHO
 9T5ZB/4lMpgqhrDFltj/lgkT3ofNtyn1bxETNW+UCU1CE6zoskySSN3j+f+1Y5gNPkoQM4r+lIr
 FE30zoBGo/fhzxPXRMyd7I6IMBahes2ciCl6nhxAKt8tktYUl94l2h3vlxXgnRdWxPMV17rlxiU
 Ys503rkT4r3I2/TIIf4R/3FSi+QwytwPUrKlStsadfujlc+/79fx78TlntXvf6j7ZUr+puL3rFr
 ekMw2mBnbDVSQydakmkr8wbfP1VsnHinoC2QDTUG1wuqTV57olunt9liine/TRkmLEs4qED3V5q
 wMrDe7lPJARrPqBcxXM8NwThSTftmAvr0ZTZfTkT7WuCnXub
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Sun, 04 Oct 2026 03:18:13 +0200, Marek Vasut wrote:
> PCI: rcar-gen4: Add missing PM ops

Applied, thanks!

[1/1] PCI: rcar-gen4: Add missing PM ops
      commit: 41f18f63d60fdb25d70d0633816bdb7185fc48f8

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


