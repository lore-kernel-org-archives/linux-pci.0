Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893635;
	b=Me39zY0iRVddeZa1uVdmQ4pHMg5F8WcpHFAglzm1s50pWO8GVDSjong0/i2C8rnPEbh/
	 0S98Dcwrm/VtWVVwgYVD6MZosqKz3MC8iF8B9p7gsNLOb2aTkcJ889rPJFfmrS0ZmGOrK
	 c3y5WbL+g+nGuVyl1+e1RF78ihW4bIzbQ4ngZaRD3++6jxRlqgexujZiknxmC1bbCo0hX
	 JU2Y+SNEAi0udbDGmYnQB5cilvCg/Y9p3bR8QDGEjZc6nRCsUr6hzklktmNvunOWOMwc2
	 YeSzn9PMAkvwDrASNr+sESEXMCUKaF9T2oTphMa3d1TPVfrlruagmfVaUkyieT5zQZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893635;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ofpeVWI3consGDzBWqgjB78mylADRIbQBjF1c/ZhASw=;
	b=rmaQOimjHn1rr/cIrbYdfAN8soC6PsrKmsh9KLg4BAmI2E29xHMD7wQQcWBPSsDSoMGD
	 /kH/fJ+e/FOmtZI/Ahhm/+K5gtVeqaMRDHBRkYOLlvqNgqo+06w8Ly/AacjwvXB5WLk3b
	 lQTkvNBXQoj9q7uhFsz3F/OjjKAt80O36EX+yiKaDas6Ow4WTcAhWP5AZ7Vd7odDRd87R
	 rSPRXbX8LOrFx5I075kkzr/9G+mRryYH3OiIVSeSjK3jpqOo7/HZCXzQxXl5NGbIt2Hu5
	 SddUCtB4TYxzh4eCDQNw34Jymknw0iqeEut7Otr/b2ZDGS4bAlpODs9fOVQPRAscGuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h4FefPg/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CD606A326;
	Thu,  5 Nov 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4FefPg/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5771F0093A;
	Thu,  5 Nov 2026 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893634;
	bh=ofpeVWI3consGDzBWqgjB78mylADRIbQBjF1c/ZhASw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=h4FefPg/tCKfPxSNxbyzPRZaXt1/xvRCcjqzNiVIlnWnpX2M6KY8sfo+UcynUXX0f
	 3UVQI7oIKdgTP9qeDN1bCi759hX4PmzikSt/fGtYGAxEQ8wYmneKz7WGwhgTa7gUQa
	 BL3YjPD/sxdR1PLFV8U/ZzJLYQiong/qcZNQlxoSNUTB1E9qBUAt5585VTHKuYCsub
	 MWBY+MKhM7NRdvusgjVsuB0A+5tAqcLYvvdzDwQlb0F7z9+eHmmKlX1stdNFqA4+L5
	 GkFM1vM0bESYfsSH0wWbrRMLW6a41afoWRHCOeDnjepj2aAUzZq3GKvNtm0OZPXkNG
	 dUElBpUJoIBsA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: angelogioacchino.delregno@collabora.com, bhelgaas@google.com, 
 kwilczynski@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-pci@vger.kernel.org, lpieralisi@kernel.org, matthias.bgg@gmail.com, 
 robh@kernel.org, ryder.lee@mediatek.com
In-Reply-To: <20261028113453.2599-1-sreekuttan2156239@gmail.com>
References: <20261028113453.2599-1-sreekuttan2156239@gmail.com>
Subject: Re: [PATCH v6] PCI: mediatek: Fix integer truncation and handle
 oversized resources
Message-Id: <179389361906.20463.1092137538074974205.b4-ty@b4>
Date: Thu, 05 Nov 2026 21:16:59 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=362;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=/1VoRA0E/iREIYQ2KlRfA9WVvI28uaBTMEbmFin8Rz4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq7KUBL9pngpeeZERhCqQgGAZZWRNID/qto5z6U
 BAN9sYMiQeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauylAQAKCRBVnxHm/pHO
 9UIRB/0cfs+uBOQN+I4FfZQqp9Y9Zm1HUrlhmtZ4uf7IUrC53DnL/ef1ErkkHDfA9y1Tufx/8w0
 xXZpjOvnOKFIE2WNMa7Ugwsa7oMuB+4p7PbqLEj91JdPfngrBdrOvOSGG9G31tGnJMpL2vO+ejt
 dmQZANpReW00TBYvu8EAE1MHptSsgQdzXFYj0yvWi6hW9it5NedZkzvDgphvEYSi1z4PgJcVk7D
 1C85TZQ3fYLZYFvCo8zj94mjWtNX4cVXwzS4q9nABWav0YWQRiuwPWhmPWAdR7BR023XV3Fpvk/
 01AglaQHIMq1hCblhGcj6hHgY2ZBb+uALmbE4YV9WybYywF0
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 28 Oct 2026 11:34:53 +0000, Sreeraj S Kurup wrote:
> PCI: mediatek: Fix integer truncation and handle oversized resources

Applied, thanks!

[1/1] PCI: mediatek: Fix integer truncation and handle oversized resources
      commit: 0abd664998828adc30df21c1ca052d3a5de910d9

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


