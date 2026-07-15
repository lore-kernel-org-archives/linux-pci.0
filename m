Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F543FD3C;
	Wed, 15 Jul 2026 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111217; cv=none; b=GhCV1ysEmrK6SfLWoYTeLREmuT5MaHRpP3M9CzPeZHCU0LHa4DRhOWKwr46nBmVy5BliaF++Epw6HPMyYptYuH6N3i7QQ82UwS1wwUCGVpH46m6ZYjwDLgTGzSmRB/yYAyescu5zgorEhxC81QVfOL0wItFp2p3xJvcLM1lcKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111217; c=relaxed/simple;
	bh=hsrq+08CrRXrK09liT/g0gZvWQOQO/nsZUXdV9HMsHM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TkcfoIlk3BEYUxZXf2OkCa4oR8Knd9phT6uzaTiV5GG+gZOd1605MfCfO5upO0c98y3vlDFNWOUlIsD7W0nhUDzC1niU0FehBQGg2M2EQB0tPvcvrzCvidQXg/SJVJvCiYEaActTjvTgmz+IuqgjNk1frmv5vlxQGzDXQhEMg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KECelIvB; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KECelIvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784111213; x=1784716013; i=markus.elfring@web.de;
	bh=hsrq+08CrRXrK09liT/g0gZvWQOQO/nsZUXdV9HMsHM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KECelIvBpUDMHw3R4XvBKJ3MLzL67kE8Cb9Ftit1sbKpm+qsRvi5RxBdOyKTDpAQ
	 hJVV9lAr25naV1SqFZGbvFSYQXd4y7j2B1PGBv6bsOFX5LcKgyVQEzH/6QpYKgtUe
	 6KJEMnK2rVQQ4EUBD7TuhglCyO1oep7OkBiZXE//B5rjOeyQIPgCWWbKtkoDXjlVO
	 7ykp/lH4i3qLwI+s6pQV90wj3YbNbhQH/OFmQ7qXTXEP2v0w7irRn4Hvy6zI6EOYH
	 xmC228fclv70qh0pdhWFKU1KV7adXZYiaM5IC3FBURutN8NrR9KBMbgwMmYWdH+t+
	 xP5kbrVhQqxw1ybLSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZI5-1wcyma0nF3-00No39; Wed, 15
 Jul 2026 12:26:53 +0200
Message-ID: <e9b0d5f8-baae-45bb-a8da-7ab88856dddb@web.de>
Date: Wed, 15 Jul 2026 12:26:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ali Tariq <alitariq45892@gmail.com>, linux-pci@vger.kernel.org,
 Kevin Xie <kevin.xie@starfivetech.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>
References: <20260714113029.326207-1-alitariq45892@gmail.com>
Subject: Re: [PATCH] PCI: starfive: Fix resource leaks on error paths in
 host_init()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260714113029.326207-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/PB5cxfvGpEG1TyyR1ZrSTkGT6iYZFtw30Eoo4umV5f0wBr0zpm
 4Q8nEuKfrGO8OZtXxeb6rUbWHJ/h2eeSFWRpubS5eLEgrmHiVK9dVwXPxjiVMD6+cWxLaOA
 857C5OLTbbpw3v017Rn7GZFltZa34XSHsWty6t9uRW3OYfZZGo2zfpdG9C6a9K9LoFSJF8r
 X6oIekjmeXOjdK7BVY4QQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZIFYztrg2FU=;PMy0LMvqvE7yPM+9SSQIBKfZVn2
 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
 nOwRgMIoAq7RsTIVc5Svc578oweAnQ

=E2=80=A6
> Disable the PHY on the clk/reset failure path, and disable the
> clocks/resets and PHY, then return the error, if the regulator fails
> to enable.
=E2=80=A6

Please avoid a bit of duplicate source code by using an additional label.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.2-rc3#n526

Regards,
Markus
