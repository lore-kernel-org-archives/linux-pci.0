Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374A3B8921;
	Wed, 15 Jul 2026 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139732; cv=none; b=YVwPGwkaXxU2Bs0JAl4HxqdWLjg5Rrt5LGbf3c8fhA4XU3n5oYhsdBchrZI6x0djws/A8mr30JIjGfCa/FkwY4iZTURwk1XzxtwfQrq6iU+aN8LxdkB4kfgzjEQjhopC2jNpL/P6uWtGVYgZ/jCyQwDjZ9lnytOIcTaeHDHG5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139732; c=relaxed/simple;
	bh=r/boCW8tUag3vbVUnlVEdIi6Afe1JlyC7Hjj6+Xnw38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBlP/SgNCTKGyA/Sp0llwafKSmx0ZVtTu1drV+9WwE04ggkBQGFiqAhaVcUj7FrOijkXP6vewRxTHV/7dux58O7zEvQC17uzDvNA3rfE/M0GqovZrainjqizQBXvjDarFKIuoaRz1juUSn5EiOzqtaumHWH8jb81NWxgvmbBBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tsQn4g3+; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tsQn4g3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784139701; x=1784744501; i=markus.elfring@web.de;
	bh=r/boCW8tUag3vbVUnlVEdIi6Afe1JlyC7Hjj6+Xnw38=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tsQn4g3+j1MH3ew9JlH13x/9illfMbMHxUs8WjNXZV8yVQoIZUuhWyz9QEiWW2Ui
	 +GFGRYXtH9yhhQCMJMQeKnZsETjedMZnxELjYfhcxsiwV2QGPXOlpp8PjTSUhI1AJ
	 jztZaV4NV9fPL3uapSKeq7z34GfAc9iE0scYK+cZmPY9auxcviKd95PEssatZmsjl
	 SN+447HWBNo6CYKjm2V82Zafgt1/u+u9U5/znprY27a9CWlywtse24tQYewObIYrx
	 Fi+ahkU2BtCykqNnz+tg1/4gZTXqE4bou+IngTve1eakPWuVCDdeHwz1FRbihxoQ/
	 6AKmyAucDpAHX7154A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1wp3N50zLq-005vIU; Wed, 15
 Jul 2026 20:21:41 +0200
Message-ID: <7ff2e16d-15e0-46c6-aaa6-99796a3fc439@web.de>
Date: Wed, 15 Jul 2026 20:21:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: starfive: Fix resource leaks on error paths in
 host_init()
To: Ali Tariq <alitariq45892@gmail.com>, linux-pci@vger.kernel.org,
 Kevin Xie <kevin.xie@starfivetech.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>
References: <20260714113029.326207-1-alitariq45892@gmail.com>
 <20260715134532.619566-1-alitariq45892@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260715134532.619566-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iXrSESyLSUan/BRAGIEFpSfl66TtiUZEVA+1l6RIa4Us9qiBf7z
 CQk7tI7Xj9Zf1xW6YHhj3FfEqsfRBkjhjBCnLh8y2KAWshcsWEWpp4b7WXCGeHcInYX1Vk8
 FtDZsDbK4oFco3d1Aduyq8q3a67wNBNB07sSeEG4fiOm7EJfTmAe5BT5RSHFGWQGnYl6s0C
 AHGmHZXUdkx9pjEzPiu8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1A/yIpozBpo=;npTwcHJPSzUgfZlWy2v6u7RylLm
 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
 =

=E2=80=A6
> Disable the PHY on the clk/reset failure path, and disable the
> clocks/resets and PHY, then return the error, if the regulator fails
> to enable.=E2=80=A6

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2-rc3#n145
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc3#n34


Regards,
Markus
