Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F023BF9F;
	Fri,  6 Feb 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405983; cv=none; b=B26DPpBfdOvZp3djE3Ojd0PQwIsazxzA9ml0YKs8ry5zinrVzNnb//IuNX4Drynn+NQ11M2+mRzawfbJfYw8CwM5labn3Z2wd5eotvkUm/R2piq7JJumr4X7spdK5gqz28wcxvV/shCCDKIcqrgFLiAnUrqnEJkE8RnWOnGkjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405983; c=relaxed/simple;
	bh=1W/POuLc90L/43xY9aDPA95yEmeX7lFeRJgAsXh+wLs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RHlR4Vu0ZB5Yhry8t1H91njbJfRNg+FYSdrTRGJAh8qdaT5Pr9iduBeHjykqbBEC3EdVoWULkVy+gQ3IzNYpc/Nq1HAEKitaXmTuKFPUUEJE7Z3phP+Fu6j4DCsoA3TyIsJnSSKmNYBsijrxVN0Ao2jr3i/gSsHBBCA7QtJIN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8aPCyiD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8aPCyiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009F4C116C6;
	Fri,  6 Feb 2026 19:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770405983;
	bh=1W/POuLc90L/43xY9aDPA95yEmeX7lFeRJgAsXh+wLs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=b8aPCyiDPPIue45tdsGh7XBvZbXyWxx4vqgRCUoKzcXN56CyYKIBDvPshpH96NY5h
	 AfgVnADNlycZ8ZySZXhL7/4i1Np8iw4ZUREPI9MDsT6Gtudnu+F+RLCuT/e0G07sco
	 zMGoJYszqjcKlUa9KeFh93CKbE9w0BSwjqyCfaqngks3i2ZO9Waam62if/XLu8DV+P
	 EzhjFp7VuXble9UJrFFDG9YSBAuAqm9trdEQ4HhRm5teNoMtiyV1f+++vOS9Xssckk
	 9J11N4Mv87knrWw4LPH/hTZwbV5feIkP2vImM8CYBfksDggA3BwmuoCilayal865t4
	 rUH7jTvSEHXEQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 20:26:20 +0100
Message-Id: <DG84JJH0JNRK.W8DDDDF2QIZC@kernel.org>
Subject: Re: [PATCH] samples: rust: pci: Remove some additional `.as_ref()`
 for `dev_*` print
Cc: <rust-for-linux@vger.kernel.org>, <gary@garyguo.net>,
 <ojeda@kernel.org>, <linux-pci@vger.kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>
To: "Dirk Behme" <dirk.behme@de.bosch.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260202064001.176787-1-dirk.behme@de.bosch.com>
In-Reply-To: <20260202064001.176787-1-dirk.behme@de.bosch.com>

On Mon Feb 2, 2026 at 7:40 AM CET, Dirk Behme wrote:
> The commit 600de1c008b2 ("rust: pci: remove redundant `.as_ref()` for `de=
v_*`
> print") removed `.as_ref()` for `dev_*` prints. Nearly at the same time
> the commit e62e48adf76c ("sample: rust: pci: add tests for config space
> routines") was merged. Which missed this removal, then.
>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Applied to driver-core-testing, thanks!
