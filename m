Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586260;
	b=yjLySFSo1wH+kZXr7QUOJaF3Jy8SxNOCqeM4N6sa4mhH7nQd4AdrX3JBl8lSB/n4t+ZK
	 EzrWqK70RmTPx+oEIwaSnah1v/SD21oMBk8qzA2xmlPZ5tEsUojXkLQXYyzAG/8+gGg9E
	 BX3KSQy8mFgcnQGQU716FAQPIcwAbZmW+rATDuCztepThpscgEXBthvz8rHuGiIzRJ0MX
	 +42m9kpozs1bJZJT5fpwFVJD5hMHhXxsnfE7OJyvhkh3pdAaGmxrUcLlTsAHiDa6oXcgs
	 OSI7eMbglgp4zuqroYEhXEIgmxEy14OLCpXe9fIUjgVamtPyqWCgEQA0Wlre6N5uMqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586260;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VKYf6lw95CTmi98ReEidc0r90LXOLMJD0m0Vs+5eoE4=;
	b=QVICcfGq8gkJ9/zDFV1EsbzlOgjR2x4fVDJjzQ3KqJMnuQIMdG5bAmdc/6hfZqu5VSol
	 ZzH3j+FYfVrX8DIopB9X/iaU7vtXyctwL7EX8MKh/wiiqnO3Aow3y+HTVtOUKDKNKs4y7
	 Y+oLhZpjep4uuk4KeYz9Zml/kDGwmw+6ZRFOQPs7Hz4GHND1rsPDTriMFVWXOKA9BUYeA
	 8szbWjDc/4SOUcpxMNVLOpXn/wQ69jn2P7ojv5A0U0QYRihxZx7bu6Tru9cEDvKtPOuWn
	 h4OrOKCSwRYS82Ba26ZnMI4AGtLMGEib2KoY514HkqyFrx8DmB0HFK/v5YXaly2Y9lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFaMM37B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26643606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFaMM37B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D63A1F000C4;
	Wed, 25 Nov 2026 05:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795586259;
	bh=VKYf6lw95CTmi98ReEidc0r90LXOLMJD0m0Vs+5eoE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gFaMM37B6ZsGXDiiENXmPj6cNVmuk50MPIpXjudK0RcajqfLM3THNGZrXr4oJaFdN
	 KxgyPxndNQzdh7KDh8rCuywxU5CgF92NGk0XXFRHni6p1ZyEeLmzHYXAHGU12brVy4
	 H+7EINoKg9TMZ3pcFkLGkAOnG8OZRecEqC6TyCe9jCVPIZJSwQ56SJ13fSVCeMmZU8
	 us2/U8MMZj7crZrSVvHjVp8P64+I+mrxmse/n3zU1V8WT327Xsp9xrh3OHxHN7vTeT
	 oUbTXELirmTI2zX9Ro10eoiu9ao8BJ2PrZb2evo74YvxMAAyvtZqVScFriH8Iow2B0
	 8DLlixhwYeT5Q==
Message-ID: <sashiko-outbox-232636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/2] PCI/AER: Fix and document aer_inject's
 aer_mask_override
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125-fix-aer-mask-override-v2-0-fb5931dc9462@google.com>
References: <20261125-fix-aer-mask-override-v2-0-fb5931dc9462@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 05:57:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-fix-aer-ma=
sk-override-v2-0-fb5931dc9462@google.com
