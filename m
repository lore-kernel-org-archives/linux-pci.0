Return-Path: <SRS0=gPUp=4Z=networkplumber.org=stephen@kernel.org>
Return-Path: <SRS0=gPUp=4Z=networkplumber.org=stephen@kernel.org>
Date: Fri, 19 May 2017 08:21:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jork Loeser <jloeser@microsoft.com>, olaf@aepfle.de,
 sthemmin@microsoft.com, linux-pci@vger.kernel.org, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, marcelo.cerri@canonical.com,
 helgaas@kernel.org, apw@canonical.com, devel@linuxdriverproject.org,
 vkuznets@redhat.com, leann.ogasawara@canonical.com
Subject: Re: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
Message-ID: <20170519082122.7f56aa38@xeon-e3>
In-Reply-To: <20170519112701.adqxvpkorrthjf7i@mwanda>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
	<1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
	<20170519112701.adqxvpkorrthjf7i@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Fri, 19 May 2017 14:27:01 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> >  /*
> > + * HV_VP_SET available
> > + */
> > +#define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)  
> 
> Use BIT(11).  I thought checkpatch.pl complains about this but I guess
> that's only with the --strict option.

Since all the other field values are encoded as shifts, doing something
different for this field stands out.  Therefore just use (1 << 11)
or change all the previous values using BIT() macro
