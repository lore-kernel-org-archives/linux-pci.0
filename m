Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBFD4A07;
	Tue, 28 Apr 2026 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777413110; cv=none; b=MGZ+3RcKvH8W+Hil7sAgpbNeekRQUc9f479Hulg7aLgLtADEZyGpIdt5YWUCoerZ5MX3SwPST2RjvFrk4Tu4akYuwQcP5otT/Rm2xh++lwHwp+SyNd8ZPzTIv/AF3rHmdQP13FtSu6OyhV8mFhmmYl+7rZKZ24gHNOJNRuAOl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777413110; c=relaxed/simple;
	bh=MN2SlJMTppEYUDkMnQA6wTGYYpPqWIvecTDxG91n+Es=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BJd+eGm806wuqsciVb4hkrFeAtEoM+VHGFXQdkY3JN2S8rk6wNJNh5ZzL6DpfcT/Mvs5gCqqjBjw0miLPDzHWiLVr+FkXlQ6sQ8lNsKE+Qtn9rnNGLtYSsCPAspVB1r80ojakTx1n7Jhjb1TcDU3k0HRei30vSRx7Jenv8SjWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roFAaWRy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roFAaWRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE926C2BCAF;
	Tue, 28 Apr 2026 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777413109;
	bh=MN2SlJMTppEYUDkMnQA6wTGYYpPqWIvecTDxG91n+Es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=roFAaWRyjxhmWfrXHKIeU8mHkoIWPqNYLBGy0PR9YeUwy3tF7jex32kurlu8qOkar
	 wQJKeKRsBLSIf0umhso4e49WcQs0t9xkYNMqhm/jMv0AqVcilo9qH0Xf6aZ/gY4WTp
	 y72UhbCi3owelEL10udL9VQMCYUSfmR4KAUlG8AqdtcqM0JROKNj7GyHTsyvlUqvib
	 CnVlIGAKJ51FbuGq3ppoaO3IqTwFfWmvqjOnnx0LcZJpBJStmJxD8f8LrZ1wdPWEd9
	 H92j68o0ZJLUMYwq9lJmpqd2ahyiV+MsbWHwSNa3of4xTNdOIqvUdkelGN5QZ0eI4i
	 hpPKci7CSLeYg==
Date: Tue, 28 Apr 2026 16:51:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improvements to PCI hibernate path
Message-ID: <20260428215148.GA257618@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427205024.254677-1-superm1@kernel.org>

On Mon, Apr 27, 2026 at 03:50:18PM -0500, Mario Limonciello (AMD) wrote:
> A few cycles ago I sent out a kernel series for using the S4 paths when
> the system goes to S5.  Some parts of it got merged, and Rafael suggested
> to split the other parts into smaller pieces across multiple kernel cycles
> to make bisecting easier.

Thanks for posting this again.  Sashiko had a few questions:
https://sashiko.dev/#/patchset/20260427205024.254677-1-superm1%40kernel.org

I didn't look at them in detail, although I did think the ACPI r6.5
sec 16.1.5 reference was a little bit obscure.  The diagram in sec
16.1 certainly implies that wakeups only occur in S1-S4 and not in S5.

Sec 16.1.5 does mention "Remote Start", which is completely undefined
by the spec but searching does find sec 7.4.2.6, which clearly says
the system requires a complete boot when awakened.  Possibly a little
misleading to refer to Remote Start as "awakening" when it's
apparently not a "wakeup".

That section also says "OSPM does not disable wake events
before setting the SLP_EN bit when entering the S5 system state."
