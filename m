Return-Path: <michel@daenzer.net>
Return-Path: <michel@daenzer.net>
Subject: Re: [PATCH v3] PCI: create revision file in sysfs
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161111143723.5818-1-emil.l.velikov@gmail.com>
 <20161114184003.gdkd4kkiet2qqe7s@phenom.ffwll.local>
 <20161116205811.GE26600@bhelgaas-glaptop.roam.corp.google.com>
 <20161117144402.GB11693@wunner.de>
 <20161117234855.GA25762@bhelgaas-glaptop.roam.corp.google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Sinan Kaya <okaya@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <b011e277-7e96-d2ea-216b-f65a6129bc50@daenzer.net>
Date: Fri, 18 Nov 2016 10:42:20 +0900
MIME-Version: 1.0
In-Reply-To: <20161117234855.GA25762@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 18/11/16 08:48 AM, Bjorn Helgaas wrote:
> 
> Popping the stack all the way back to Emil's Nov 8 message:
> 
>   When using the Mesa drivers alongside firefox [1] (since Mesa 13.0),
>   glxinfo (Mesa 10.0) and others, all the GPUs* will be awaken,
>   causing unwanted delays and increased power usage.
> 
>   [1] https://bugs.freedesktop.org/show_bug.cgi?id=98502
> 
> The bug is about a delay in starting firefox, thunderbird, or
> chromium.  I assume the browser starts on the current, powered-up,
> GPU.  I don't understand why we care about the revision of other,
> powered-off, GPUs.

We don't. The problem is that the current libdrm API unconditionally
provides the revision. The plan is to address this in two ways:

* Add new libdrm API which allows the caller to say "I don't need the
revision", and make Mesa use that. Users having those changes will not
run into the problem even on older kernels.

* Add the separate revision file in sysfs and make libdrm use that for
its current API. This means that even callers of the current libdrm API
will not run into the problem with newer kernels.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
