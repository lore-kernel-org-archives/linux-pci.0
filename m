Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514963;
	b=W86hNX5U9+0Qtf+8YfUjhAzkzs2KyERMuuLu18prwfpp0cjYZpmoU4oCMpoEgFFUmdhZ
	 28GFzLwkvVhim7FQjDY915vHEAhxcTIYqOLtGoWXqm/1m7j3CEf409eseORTmXdmfwyeo
	 B4l4I1Ys/rw025WRCsVlijkAz45YgoeUKqRNj53pG7z68UmT7yo+cRau+DeIUe6lF46+M
	 H0aKnV3kH27OnFUzXoDTwh0JJEHT7qyu11tSHXdByKtpCi6KPsAj8nbnwq5uuUubClifK
	 2Dw5QhX/1BcPKc7byFvBvsqMpm/jya+NOgJVzWyt7Vzedq7bDy2faUkkfaoiZGoRjNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514963;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TMQGJ5fJ9MCh2/Z4MJkdTHs79RpV7IxXJFfpO1AlsOs=;
	b=1Cy/pQ0NL4d2p/ICSD8e5ZWG5cgxEUt3wuIy5j8iNsFnQgT/5O6uSuagsQ09kWguooKk
	 FyhNKDskI8E3hWb1b9UdKXAOUmmlwzLfouGDSZ4ow2q0goInMymgqIL+iHuBtxL5DSK7/
	 e0saY2yzFXmFqp3Hmng4JBbnxBaIh7g+EZteMqNxNNYVO+XQDpOAvD8DZGksqLP3SjXfa
	 yePMMf4hbJNAwsfvCc6U+wy/Zrj6HQcpNC7cdhXOY/uQce2q9VRUc3T3xEOAzg5TaC4m2
	 frDQlK6I4mWh15n6VGi5GeiT8lRPcjV7ytjBbc8nIPxcYAQomQUeAtIHXMqXyc53pkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0E606A323
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C001F000C9;
	Tue, 20 Oct 2026 16:49:22 +0000 (UTC)
Message-ID: <sashiko-outbox-179378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] driver core: warn should device_move try to move a
 need_parent_lock device
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>
In-Reply-To: <20261020164435.80499-4-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-4-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:48:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, no device has need_parent_lock set and is moved by
> device_move. need_parent_lock is only set by the usb bus and very
> few device types ever use device_move.
>=20
> Add a warning to device_move to catch should it ever be used on a
> device with need_parent_lock set. The combination would break
> the immutable relationship needed between parent and child for
> need_parent_lock when locking and unlocking both.
>=20
> Suggested-by: Tarun Sahu <tarunsahu@google.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D3

