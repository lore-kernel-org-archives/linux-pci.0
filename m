Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071167;
	b=CPYwh+w1RgNNgM2kecdKjMfWblzJjoRN3aXgx4PvYMVzybWdlfUP0SCFuH7oWGAxqlwn
	 hRBwsjTAg3GBHosHUubA83QnS+qqUCWvVfY21TNrsMsi+fHGB6SRmIcQv6I+cBpqpK0rl
	 KmT9yx36MDsM1UBlgMcGzsA8ManmnKLH/XONgKx6qz1ZsRpJ3x2DKUghMz5vAp2OqHJTk
	 5vMqbEDWPQRN8uliiw1oDMk6qWNocaBQnmJH8xXqSoSp+UmhweREo7iR0mcfZWbkwRjab
	 hOXgtlCQzqBZ86lP1dnnL3sxk/wOb6J4PkX364jjnDFaiM4ONmUqyBVZsvxaptrLD1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071167;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=3B2bRBOpZdQJBdPeYcBE/ImJEUR7JL3p3x1iB3QG5Ic=;
	b=K1pWif4XXCEsVddkMBmwfbo0iXPdXtPyAhsWqWIYCpbXQg9BOCS601xp9paTTTftS5JT
	 iW6YQs3Yy8uMe116+R6yFeo8eiBVANi9W+hrOXiNtm7sQpBhKB57N+N5ktfq4JbJD0yjn
	 uLxNcfnsLhIIL4WDOTtz/qM129J9fPRlvDloE0NAqlbykrprE+3+1eA9FMelqB7HzBDyO
	 FLa837YR369Ylr9kFwSENde+EV7HK6dAhvkYzekKWlSYE25uoZlr7NfWPXkvD8g4/2kEx
	 mYJVcWcxbdiKOw2wK2NDpdQ38+YhuFON+OILbasa5HRaFF3BXJrH9qao7Di77Ta/nAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n24a25f6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CA606A33B;
	Sat,  7 Nov 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n24a25f6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745471F008A1;
	Sat,  7 Nov 2026 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071167;
	bh=3B2bRBOpZdQJBdPeYcBE/ImJEUR7JL3p3x1iB3QG5Ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n24a25f6R0VawmmQunC0DW27O+t4E1QrIT8l8XRT2iYs4tZJspHBDBpnIOlPwmHlY
	 jGaOYfdBlQbNDIaT11Lfy1epWt9Q2Qj5h7ExuMRoZW3IYFhV5R4ABKltXvaX6KsZco
	 lTkXLbrV9dw02dmHUwcO0SSn5vNlYw7PjKxIak/lM1mFX92QNabrUPTfnpi9OQcRCU
	 CTq0JJJYBTQdsvpsWmW5/7zNte+g79lRNoK8BbaF9xBK6FAZtH9r2pCZQjCVFk/jVl
	 +i8Zek2m5hFWI1hhIOhAlTtrAWq2jE/E8myFNbWmcyaAZkJv9Mfrh/Ru6QsGTMfvxG
	 9ZYAzlS4wh3iw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eugen Hristev <ehristev@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103-iproc-irq-v2-1-dc7223df35fc@kernel.org>
References: <20261103-iproc-irq-v2-1-dc7223df35fc@kernel.org>
Subject: Re: [PATCH v2] PCI: iproc-msi: Removed potentially endless loop
 handling MSI events
Message-Id: <179407116636.87400.9305628985519602729.b4-ty@b4>
Date: Sat, 07 Nov 2026 22:36:06 +0530
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


On Tue, 03 Nov 2026 23:20:12 +0200, Eugen Hristev wrote:
> The iProc MSI chained handler rereads the event queue tail after each
> batch and keeps processing until the queue is empty. A continuously fed
> queue can therefore keep the CPU in the handler indefinitely, starving
> other interrupts and causing RCU stalls under heavy Ethernet traffic.
> 
> To fix this scenario, remove the loop that keeps reading the head and
> the tail until there are no more pending events. Read the head and tail
> only once and process only the events recorded in that snapshot.
> Update the head before returning. Events arriving during processing
> remain queued for a subsequent parent interrupt, allowing other handlers
> to run without imposing an arbitrary event limit.
> 
> [...]

Applied, thanks!

[1/1] PCI: iproc-msi: Removed potentially endless loop handling MSI events
      commit: 2fc457946ee05dfdf080c35e084a9e136e38c3ed

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


