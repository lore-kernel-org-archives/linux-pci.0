Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515731;
	b=CE0gSqruHDGnhZIRhP6149OAT9WA4CYgIjVlLd6LejWm37P/9+WRKFGAiCMBgxNu2W05
	 yLYDlmcUydpsaIl25rQNPLvO0LMdV8fDwKHb/rvh/TpAmz/I00n5F8Enp/jF7nOYnjNYs
	 pSHgde5q4DaIE5iJ2Ymis1IdbsebgWya7kIQLIXSEunz/HNUFMQ3/FugpVfGxCby2vt/3
	 5obL37hXR+qFYRUeqmcofZC8hRWNzP++MIzL57OdJkXHHMRjFHrVwOHepsDoSWOlqVjMk
	 1/KP2Qoq/I1Oia+cHeyEJJTyVryJ0t4C2/W/wRyhJqS3tPdkaflSuSVK2xm3y90bEeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515731;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BPb4QYBcb/dmeJSOGxSaAo2epXBBD2spG8U0WsoQtd8=;
	b=vgJa9R8FnofzTYfyL2n7dUXjt2BRRk8s4zy/CdI6p1oyWMHqCsETcoz3mgCSUpAnvemU
	 dt3wgdcQzsFzN8SnLdO8eMshYFENZmJsk1WWxSGkEckyn4xyB8E8IWYxNumaNw5mtubfl
	 F6kICD18fbdFOJYMx1G0guK6fAdlaLShHqKjNULbnAz4xdTHLFu9suCw1aubZ4sfLYbyj
	 jcnvGNWt0lcGug/df6oNI2bAWfHAfWsFvcLiW0vFN2GHRhvTfXHK3tlTRH1d9ISrCr/Rk
	 1PZP7VVh/JPpAdVXmNBulSrFJ0oGndW8BfQCFVaa9MJiaXdbKXcsphjozHmtQBKXgwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68529606A320
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 17:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063A61F000C9;
	Tue, 20 Oct 2026 17:02:09 +0000 (UTC)
Message-ID: <sashiko-outbox-179394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] scsi: Enable async shutdown support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>
In-Reply-To: <20261020164435.80499-10-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-10-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:01:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Like scsi's async suspend support, allow scsi devices to be shut down
> asynchronously to reduce system shutdown time.
>=20
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D9

