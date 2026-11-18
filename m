Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046245;
	b=xuJRYdamEN2F//5zJS7KCVCZ45Kj0F6BHw1DF6E6tDBbcwDooMz9hZzvo94kR0jyUlsM
	 omrsdGQ1eWMh27cTDIdz+tQ3fW8aFiltFfZL2mFPkfqxsE1tdjnDOjLp9V8yiXQaVFpKl
	 C+LwA9clcpX64hSigEvSwdbyKQq92FX39/w2N2Dn/7vnnRyL9K2hUZRa1hzhO+ak3Q/UC
	 R8Wh2QOvr7n3rnPALO6XjMJS74UMqCQAmEpGozZmMhddDYnJEsDGuSIolVYXHp+I+VPTQ
	 Nl+OLDo2dgdzW7D12XC2rJpwLKC/iYtglujW6OIihBsu391Nn/6tkQ2AJtiCqDWyf4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046245;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=hGkc2X+O0aenFipJnJuCddUF3up8YjP06AEbn7gF8WU=;
	b=zMZo8vY7WZ0hmI+aMNeyY11wcNDsLFKzGBgJe/h16DE9L+HFfNHLaffrflkVKniJYZac
	 nr185WkWYNSGeUVNQpOSeNXxKXZrKXnDs2KQ0eVw1sjLxRqLaJ54fPU5nkjaFDT8vlkAS
	 0JWdQMyh1dXEr/k/x8EPZAtFd6VhdqYbDbyeCYe5GK++6QtKyFAvLp7Zul+94W7vbcZ+s
	 V6hOOT+NbnKnkWkBICbdTsPuePk94JqXqkMOEGpFTlLFcGZLo2OM23p1rud3gIMrdBK+s
	 0gTNA/ziaFdRIMf40txlKGY/gC2u5yFmiR3kru4knmJcs0nZx13vC3W+gU/VgS3cVwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=A7foanMU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3RkSpiOv;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014C606A332
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 23:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9014C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=A7foanMU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3RkSpiOv
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 922D114001B6
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 18:57:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 18:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795046242; x=
	1795132642; bh=hGkc2X+O0aenFipJnJuCddUF3up8YjP06AEbn7gF8WU=; b=A
	7foanMUPUfxIv3H1FmDkyuzbxOrNYzCiiZ1by2+ly7U+jwKgB8zqOVvB8DqS36ZQ
	R3qPvZIBwJKODFDu2VYsWrK7VmPWVmovNW6ZCYul36VhEfNiFfTwFZS4q556SiL5
	4pkgJFO0WYEy0L6IPx1HWyEnIaEyBR9jZnhIydDB1gv+ELprFrrGx+Y/DMGN+rFC
	USlQZqu7pIZMbDsRRWCMgA0JOYrNI3gzmFXNMWojNRsPqIINo9FXCfRTho4RP/Kn
	vB4pp9XdjdWQxG8YT8sID4mBgYbB3jvJ1JPxzkOtLv4BWE1VP+scZBYJEAqMZYQb
	sJgAS0KEmf5EMVhHEskag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795046242; x=1795132642; bh=h
	Gkc2X+O0aenFipJnJuCddUF3up8YjP06AEbn7gF8WU=; b=3RkSpiOv7+ef9rqjv
	rUUw5AIdUVO9YnKOv9jpRW3jXFfL+v5kVXGl5r6lg6DCOpT4FLTy9XvTF5Kv7+Ei
	glf0F1W9yeskG8xBGIhcZdOzNFtpbdyUJZ8+flQVYEbbCgcZkFAr/7S3DOc8inrr
	m8IY59bG+8dixNFIK+Tc9WSWv8seByDZlMc5QR+QHjDQ0GfQ6Ha9RCz0gr0OR68l
	W75Gm1m3pF0AFgYJzRp4GSm+Wj/CBrtZF0H6qIYO4Tbk45PP0XVmi+upkVgP230l
	t6YHRy47ziF3z38GE8z8Z5ohy7+mKqmgQv9he2yqpZ4ck2+KlFshq/UIRE/q10RU
	9h+KQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795046242; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:wPG3SbZ/wMY9bO+v5k+/NgoGllsM8ioyZd2dWPItZiFQju0
	az+tcvYZ6ODxxPd/7u23O3SFQLpnBio2oX1lbJqopUdrudqIG801c1zakQ4Zpl4s
	M7m1Ile63duQE4SlDsdVcoJ87+g0vgSHDkc/Yc6YhymU6QS+WBQPrxpJU8koPIWE
	Fi3iZoY35ZuiopuxtofRh1j/+q2rOlQxBdUs8y/nGx46Ah/Q4Cw2X/lm+NaA9D3s
	xREfhx7faUivnZhUD2yPpBpC3tHr9knRR9xfUL+vaHsqntC828Zq8hsPf1whqDJV
	N9aezQFb9yp/SoldnlCf7Xx1XuGJrGE8IefnnCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:G6j1WEbAHIq8tWmPJmZZjibdOMkBo5R3V8kRbHFfYgk=:TQvuQbnPhs7gSThCadxJaJQQTnwfP3uEZUne5G+6jaY=;
X-ME-Sender: <xms:Xzv-aiHQ9j-S5ueg19b6lfr9ws1pGbGaGXHq0zE10VzWphYwHGk-5Q>
    <xme:Xzv-akm4VSOI6jDqluwD8uyXoVA4t5iYF3643I2IuE22ruPOAyl-OrwiLWUTZruUW
    XNuW-3qoq3jVDNoMAaLfev-2vB38C5o9ExK4Og-WH06U0C-9nWrq38>
X-ME-Received: <xmr:Xzv-apNqb9sRFzfeQ0TObntKdaVhKxHsPsSsfhYT6wfrXfbVxXxSm_4vBPDF3B7e9ZixTC2uvb0>
X-ME-Proxy-Cause: dmFkZTE0Qtik2h0LMLqrIgUWaI4CB2p93T0f1m2Kzl/l87lwNGBwuAOgQ+AfXvskrVJH2i
    p6ljHDZzG0CdtMT8T/gJ0T/Ti8sgeV3YeHpVIWrG+q0gmcN+rSNf86o5eLrSjjxw191yW8
    QIuwzR2/xbFWQj1RjX6bpXbsd5hi5tlZCTkPfY+KJY0UFP3Mvtfj1CKS2rlcsiSjEsKO6w
    cb1dgXvYDD+YDFjqo7iv6CO6NMKEUTzrEzlD1WbyPxC8PcFVxrf+LToTyWzvM6ACXwfG6h
    SY+FoWkIfjoa+LvWm3E3FkRmWzkd0723UYoRV8j3fBKkHkovoceJNgnLcDQpOIPuy/7Nqx
    ygevKGMYWzOodp2z/0YktPtXaILj/vFOCX20D35s3gJpaq9mBVH3cxqskd5V1crriXXNK6
    eEdtcVEJ1nzEs6LC/9cx8cg6p37d/t4I7m1EbbqJsLK0kC2O+eSuaR9EW1VqIwUmAlCFm4
    /GRq2UggEiJ4QZXe+/bW+PRDGg+48u60CZqg/FNZn+63LgWYsJZIw+93AHFDyYkrOg4LSG
    nAB92UkBH5u7VgvifKkxVw1/+aV0Kq7r1B9PA8G/LFV7IdgCLinBNWI9N5zCca4vKisFtW
    aeFstJ+I6b50r2tMGDdMpGqSQlLGgCG9Fq54GgbgrzWbuNVj8VkjaYbDrwwg
X-ME-Proxy: <xmx:Xzv-avF02BQ8n4g73EHJJZjI-AJeyThCD84z6V54fKZOR8AoSQdkCA>
    <xmx:Xzv-alvipkmumC-NaUJOo3495pRv7sntm5o3p2h1ZXEwlG6Path3ug>
    <xmx:Xzv-aqShcvD4y1hQxHNj8CA0rCwg-4ve_VylLntsHl7LcbLLyKFmGQ>
    <xmx:Xzv-agFZFdSGyJcdd6rw4KKEQxNavsCB5hTfO7O0NwRBN-MqZQkHFg>
    <xmx:Yjv-apYnMgJzheWFzJ63cPRZHEGj_u_5UGJwkguoka3gsS9UsFzZK2Va>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 18:57:16 -0500 (EST)
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Lechner <dlechner@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Allow untainted driver_override for PCI stub drivers
Date: Wed, 18 Nov 2026 16:56:43 -0700
Message-ID: <20261118235645.2907908-1-alex@shazbot.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the name suggests, the pci-stub driver is only a stub, it performs
no hardware access and is typically used only to prevent other drivers
from binding to the device.

Similarly, pci-pf-stub only interacts with devices through the SR-IOV
capability, and may be used to create VFs on any PF that otherwise does
not require a PF driver.

Both of these are often used with driver_override, as this is our
standard, non-racy mechanism for associating a driver to a device.
With the introduction of support_driver_override in driver core, this
use case needs to be explicitly flagged as safe or else the bind will
be denied or taint the kernel.  Declare these drivers as safe for use
with driver_override.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Alex Williamson <alex@shazbot.org>
---

Uwe, both these PCI stub drivers should allow driver_override use cases.
Thanks,

Alex

 drivers/pci/pci-pf-stub.c | 1 +
 drivers/pci/pci-stub.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
index da4db4928907..328fb4a57092 100644
--- a/drivers/pci/pci-pf-stub.c
+++ b/drivers/pci/pci-pf-stub.c
@@ -36,6 +36,7 @@ static struct pci_driver pf_stub_driver = {
 	.id_table		= pci_pf_stub_whitelist,
 	.probe			= pci_pf_stub_probe,
 	.sriov_configure	= pci_sriov_configure_simple,
+	.driver.support_driver_override = true,
 };
 module_pci_driver(pf_stub_driver);
 
diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index 9bc478df4e8f..acbd43c17adc 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -37,6 +37,7 @@ static struct pci_driver stub_driver = {
 	.id_table	= NULL,	/* only dynamic id's */
 	.probe		= pci_stub_probe,
 	.driver_managed_dma = true,
+	.driver.support_driver_override = true,
 };
 
 static int __init pci_stub_init(void)
-- 
2.54.0

