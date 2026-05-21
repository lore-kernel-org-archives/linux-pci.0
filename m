Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6437AA83
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371976; cv=none; b=ksOT+QQdZfiBRlED1QcmT/w5a5rDM9MESes2qeIQtmh9boZHgF/+BqaPitx3KXn8SPVCiaY3Z6lImoewivkSqDMRZ+Wm15V9zD7kO6u+CDI5lf+6y0whcuSBIpak7aQMQsT+vMQIL0IeJE0UgIxoshZZSakCr+U5dAsl0u+rnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371976; c=relaxed/simple;
	bh=h+4NVJo3wpAjspHwkhwsyzZn+zEl2CEEOehXzRGNdBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H8iIa9KoHpK1zTzLxo3M+b7iCSGs6Nhck+TeZO/MUoLGsGRGOnmkgF5WjYb24LyQ3mzhM9is6XDPj+UqTo8SJkkrQTMCpyvfRiIE8MQa0Nkg6z1QWjOveDBuiM/qHgbbo0KoGaDPm3GhMaOWuUJZohMN37nuDvq4JdIfpu/n5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jodHEZLM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jodHEZLM"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8279604464so9098289a12.1
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779371975; x=1779976775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqeEG6FXEKElqAGUt/Z2qfbIbuB++N7b4Fh1Zt6D5dk=;
        b=jodHEZLMnrXvcr0U+8aiQ3+8HMthO764B3RtgzEf+7ztkCNfkmkIlQBTfUmc0CO1Gm
         znKHCX5+9bAECaG80vh/IPP806tKIqZE2l7HZLe1YU0HCE1c+TVzdByotFkWkoU+YEws
         qLgdufxQuD2gsyG2s9NK2v18HBYBS1w+SMsS+Qi6jr0LEmhA4R7O7tZpYus8VaPMyFeG
         15VYXBj+eYi7/OswJ5AioWab2qhZVYFRjyf4SpApvc+UkSyiNxbsaWg55EmuzRTPh+T9
         X183BhHSUrQrVCzdTIOykwkJ84D445JXsSdEAvmO37Cr/WfIjw3mclOhGc8OX4c80G1x
         Di8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371975; x=1779976775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqeEG6FXEKElqAGUt/Z2qfbIbuB++N7b4Fh1Zt6D5dk=;
        b=Btt5IdBPZ/NdYSBc/hzGFoKL4toJQA5zCrxFs2LMYfQm5Wrfxi+XgPPSVrqs/GAHq4
         +ub086u6TWrCzwi9oFugk1lmWVjwOsHWmNFOB1G/85ylpzMn7B1Qqxb0vH03qka3kcg+
         w114u6Kj1oc4JBuUDzJxgEgfIL2k2FUHD9VNsOxLXdzvFc8CARtB4NRLjDJbRZgP6AeF
         ZBIqYCctVdUlLooGq9/4F23itQJTwsXSeVkMIBhjgwByPxQ2uU5X52nBQB+/Q54FIm1V
         OLMVX2TRSxz9Is8CBH28zYlVduJZ6/b/hRDqxysVZkG2BmPo/XD7JNa1lGjncQXnLF+1
         ScyA==
X-Forwarded-Encrypted: i=1; AFNElJ+CZrS/1++vbwgEPp5NoRkFlU+ulIJb4EMwQaa9sz6Mh6j9WqjQTiCfq7OC3dTqHnEEi55DFA5Z5YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVyaNicKZgMzI3iqZlgKczYV00N913gODl3Y9q5QPNu1wVPbCB
	N0v66KDwAsytXj4PbzzG9iIKGgECVHiGEhy4BqC/Av/DGUimX/9DehSVhpFVzAIXieg4eSJWzn6
	v+jXlrg==
X-Received: from pge1.prod.google.com ([2002:a05:6a02:2d01:b0:c79:83b3:cdf8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431a:b0:39c:a78e:dba9
 with SMTP id adf61e73a8af0-3b308ac1b14mr3725831637.40.1779371973881; Thu, 21
 May 2026 06:59:33 -0700 (PDT)
Date: Thu, 21 May 2026 06:59:33 -0700
In-Reply-To: <20260521133326.2465264-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-4-kees@kernel.org>
Message-ID: <ag8PxTTi5NxT51EW@google.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Eugenio =?utf-8?B?UMOpcmV6?=" <eperezma@redhat.com>, Jason Baron <jbaron@akamai.com>, 
	Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Kees Cook wrote:
> Using Coccinelle, rewrite every struct kernel_param_ops initializer that
> sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> for example:
> 
> @@
> declarer name DEFINE_KERNEL_PARAM_OPS;
> identifier OPS;
> expression SET, GET;
> @@
> - const struct kernel_param_ops OPS = {
> -       .set = SET,
> -       .get = GET,
> - };
> + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);

IMO, "OPS, GET, SET" is more intuitive, especially since that's the order used
by DEFINE_SIMPLE_ATTRIBUTE and DEFINE_DEBUGFS_ATTRIBUTE.
