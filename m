Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509C14BF97;
	Thu, 26 Feb 2026 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064869; cv=none; b=UCDUrCo/8s7jKn4052Q1Ezy5B5Z+st5CL0e00xELLXkIMs/3rcyJ+IbbL4Xiya8911Iexyo8JUkIqoLWWWAOjWNOHfo3UvNlqAOURYTE3JhGK8mFkRd4zLOfCWSCY1DrhIE1vEodjAED6t/pm32tmGaDKbjYce6fa4Bw7hjdOHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064869; c=relaxed/simple;
	bh=HzgWSanUYiV8Wi6BUPvg+V46PMaO5xRpf7YcCw8co/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLKf+3j/0IGb/SnUIg+9dYniR5BPs4i/k3oZbvKZne1B759iXk5nLT1MHEkZgrE1Vpl2Z6iU5fWRLQBrbR7tNjIroEDhq2DomFWvdphQU5ikRdGwT35JeflJwtHT2PMy44e2VBXoCiJUU3uw0XbkHrijNSlCmO8R+pMvzC0G+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id EEF7D1C395;
	Thu, 26 Feb 2026 00:14:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 111131C;
	Thu, 26 Feb 2026 00:14:24 +0000 (UTC)
Date: Wed, 25 Feb 2026 19:13:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 3/3] PCI: dw-rockchip: Add
 pcie_ltssm_state_transition trace support
Message-ID: <20260225191342.6025c3b0@fedora>
In-Reply-To: <6177ba1f-c89e-486a-fdb5-9344c6551d72@rock-chips.com>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
	<1769047340-113287-4-git-send-email-shawn.lin@rock-chips.com>
	<20260224091115.6e32c38e@fedora>
	<20260224091601.48a7b3c0@fedora>
	<6177ba1f-c89e-486a-fdb5-9344c6551d72@rock-chips.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 111131C
X-Stat-Signature: t841fxjk1mky8pmyyp9by8w3fubijr6i
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19/dSNO991F9MDut7wN2qrCWlhj3EPOQT0=
X-HE-Tag: 1772064864-882250
X-HE-Meta: U2FsdGVkX1/HiYaZRW248n0xpLIre8UsQzpzQlA3Z8SuRsYMaqAOxcVzwJvTJ3A6lKPdhHrnHSQ7KFLJQTanN2tli/FRfY9H2UMvQuAc+qxEXXOtEfBHJ1OvMf/ZNpmzpqudM78kX4pPbU725KfKF5vxDNZMD2SahAo0vEofsKa+i0GboLDrsP3aZocfw2ryXHJQzIDPwBjs6KPVBtGWke+SUV6EUatV/wMP9KdfancbVedZ+1MtoxTy9o8hJNgXgxWT06yOdsrrSeH3BuHG4E9BWq8yg5/w8HysLsR9GBff+GNlps/5uf1yP9k21O/1N9u30p4wDn0Fq6q1g0QAgY4nxw3DuJ/xAdYiYQQE48uQpPhnr5dGAMlB0he5ty41

On Wed, 25 Feb 2026 09:25:16 +0800
Shawn Lin <shawn.lin@rock-chips.com> wrote:

> I must admit I borrow it from arch/powerpc/include/asm/trace.h and
> include/trace/events/i2c.h for reference, where the reg and unreg
> just increase and decrease the ref count to indicate if the tp
> should be continued. Sure, the static branch could be used instead,
> even without reg and unreg implementation.

The i2c.h looks like it should be switched over to the
trace_<tracepoint>_enabled(), but the powerpc enables a static branch
in assembly, so that one does make sense to do it the way it did it.

-- Steve
