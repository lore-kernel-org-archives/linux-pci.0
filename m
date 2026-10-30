Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380969;
	b=DpuON9r3sTMrNh/SMmK9lGQnqjF5kHY99OARMRd10qI3n41iLUKdY00qFMIxOCASihUa
	 rPKWe650ACchLUX1vuNMSSlGTo8wwiKasEOmX4gQAwUdCLmnfBKocAfU7C2oWK1jnEPXN
	 ab6SvtQjdi4hCmpTYmaUZ3VL/CXhBIiR4DANOZcE33sHfSVcTH9yNGgnSkrHfasnk0DbW
	 lNy333+y7DGyHupLOd9IoBmogfAXFw+lpRGvKTDntSnw1RgxD5oewb+xiaU0vRuZPL0IT
	 H5vjWhQ+2j9G2OsYd9MYd498CgqmGOvS59+bG+4tNo/PXRK7Hx6ZX5MmSAoeKw7CnbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380969;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=AbWHoPwXUxv+0zxO3fNFnFkhWpGWb3Lui80zNc6p+r8=;
	b=OMAmNouHzlHevZUYr8W7tVXnCrq/y1IrotZ7C/bi5CVU84CrxHi366G8fveisPwM+P3o
	 PXTJjGzWwQMguDqkSvyxAm51CrAj3/KkuopQd8lHCoqtYe+y5o1NxMFf8e0b4MutFLwOT
	 BDFERBgI1VnezG1fOh/rzVUnuPJgaaz5wFq2iPelf8K9vd9xeTFw9IOCNI6oPnHcSmYGM
	 QeOZ5oETOZLQAcAfL5hxN2cnV6SnAKSHw58IInl+NACBesQ7uX+KxQyxCt0gbp5RC3Cgq
	 aLo4m008dioI/+zUHkMg1rhdtD932U5ZxCi1an1GaZi26wS2uOvQ/heSHoKFxPzfrrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FC606A31F;
	Fri, 30 Oct 2026 17:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53A21F000C1;
	Fri, 30 Oct 2026 17:22:40 +0000 (UTC)
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] PCI: iproc-msi: Bound events handled per IRQ
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Eugen Hristev <ehristev@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <309f6f13-b010-4818-936d-4b7b4b389239@kernel.org>
References: <20261016182124.GA1884550@bhelgaas>
 <309f6f13-b010-4818-936d-4b7b4b389239@kernel.org>
Date: Fri, 30 Oct 2026 22:52:19 +0530
Message-Id: <179338093960.40615.2809022600772649565.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2945;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=NhrgfYtWWMAeXIzEEs5sdas0i8AXhL3y5gJHreUA8i4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5NJaL0b7jZnx9aXTpdju9tpBVR/Vq5ouNes+V
 7Qh7Mmpd3GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauTSWgAKCRBVnxHm/pHO
 9UFRB/9buwBUUSMn0bkqgILUriwc0wnyczcrScnvOGS4kpDnEMN46fnOiIiBJiUTnTzZ7xM8xRO
 6BtufB6deKYUwrB7az34W5VDiN1qm+JOml/Lt4Rc1XX++szyeH/oUfH+XBMOMPANTQKahLi/IcN
 UoGbIteeaGTW0sWJ7959ZsFyycQ20LWs298/S7kj5N53Y6XHvgD9LaET5t3lJhLgv66IlS//eRx
 B1ayn0MsNWk7B0bDvGwZEKo4GlpNf3BbJS+SJOg1Cb6QotVMN3Ycxlr1aPXgtac0AV7m38fumKx
 Tt8AaEU6kglmDgorvqrPL5xn28SyjKYD4ANBGaSdCefaJRbK
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-16 23:10 +0300, Eugen Hristev wrote:
> On 10/16/26 21:21, Bjorn Helgaas wrote:
> > On Fri, Oct 16, 2026 at 03:18:53PM +0300, Eugen Hristev wrote:
> >> Limit each iProc MSI parent IRQ to 16 event-queue entries.
> >>
> >> A continuously fed queue could otherwise keep the chained handler running
> >> and starve other work. The budget still drains pending events and lets the
> >> next parent interrupt continue processing, improving fairness and bounding
> >> interrupt-handler latency.
> >>
> >> Without this starvation avoidance, one CPU can stall indefinitely
> >> in the loop and not serve other interrupts, timers, etc.
> >>
> >> While testing it with an Ethernet NIC,  when too many MSI interrupts
> >> come in, CPU might get starved:
> >>
> >> Connecting to host 192.168.30.1, port 5201
> >> [  5] local 192.168.30.2 port 52586 connected to 192.168.30.1 port 5201
> >> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> >> [  5]   0.00-1.00   sec   240 MBytes  2.01 Gbits/sec    2    334 KBytes
> >> [  5]   1.00-2.00   sec  63.2 MBytes   531 Mbits/sec    1   1.41 KBytes
> >> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> >> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> >> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> >> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> >> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> >> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> >> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> >> [  177.568497] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >> [  177.568913] rcu:     0-...!: (1 GPs behind) idle=28ac/1/0x4000000000000002 softirq=28922/28930 fqs=1
> >> [  177.569457] rcu:     (detected by 1, t=5256 jiffies, g=21629, q=819 ncpus=4)
> >> [  177.569870] Sending NMI from CPU 1 to CPUs 0:
> >>
> >> With this bounded approach, IRQ handler will complete and continue
> >> to serve MSI events on the next handler invocation.
> > 
> > Is there something unique about iproc that makes this an issue, or do
> > we need to worry about this in every MSI interrupt handler?
> > 
> This is not specific to iPROC, so in theory it can happen to any other
> MSI interrupt handler. If the handler has no way to break the loop, and
> the condition that generates the MSI IRQ happens continuously, the same
> situation will happen.

> Some other drivers e.g. take the IRQ state into a local variable, do the
> task, clear it up, and don't care to read it again, like the iPROC is
> doing, unless another MSI fires.
> 

You should rework the iproc handler to read head and tail outside of the loop
and handle the recorded events inside the loop. This will avoid using any
arbitrary max event limit and allow other handlers to also run.

- Mani

