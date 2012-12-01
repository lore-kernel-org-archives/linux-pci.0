Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 1 Dec 2012 12:43:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Lance Ortiz <lance.ortiz@hp.com>, bhelgaas@google.com,
	lance_ortiz@hotmail.com, jiang.liu@huawei.com, tony.luck@intel.com,
	rostedt@goodmis.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] aerdrv: Trace Event for AER
Message-ID: <20121201114310.GA7853@liondog.tnic>
References: <20121130213330.7649.51101.stgit@grignak.americas.hpqcorp.net>
 <20121201093614.720aa96a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20121201093614.720aa96a@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 01, 2012 at 09:36:14AM -0200, Mauro Carvalho Chehab wrote:
> Please don't call it as "ras.h". Call it, instead, ras_aer.h
> (or something similar) as, if we're moving the tracing back to
> include/trace/events/, the same should happen for the memory error
> events.

As you can see yourself, include/trace/events/ contains one header per
topic so having ras_event.h and ras_aer.h or whatever, doesn't fit the
scheme. IOW, we want all RAS-specific tracepoints to be collected in a
header called ras.h like the rest of the subsystems do it. See rcu.h
there for a good example.

-- 
Regards/Gruss,
    Boris.
