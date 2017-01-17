Return-Path: <SRS0=+39a=Y7=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=+39a=Y7=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 17 Jan 2017 17:55:51 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Lyude Paul <lyude@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
	David Airlie <airlied@redhat.com>, Peter Jones <pjones@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Peter Wu <peter@lekensteyn.nl>, Bjorn Helgaas <helgaas@kernel.org>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170117155551.GL2023@lahna.fi.intel.com>
References: <1456065516.8360056.1483572074197.JavaMail.zimbra@redhat.com>
 <20170105150646.GB21446@wunner.de>
 <20170105181322.wnvdytpgddcdk3ry@redhat.com>
 <1931628154.8613274.1483644995907.JavaMail.zimbra@redhat.com>
 <1483974686.28993.3.camel@redhat.com>
 <e16ce603-1d40-9aef-c755-5e2e0322668a@redhat.com>
 <1484167244.25614.1.camel@redhat.com>
 <1484183615.25614.3.camel@redhat.com>
 <1484186688.25614.4.camel@redhat.com>
 <20170112021235.GA24156@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170112021235.GA24156@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 03:12:35AM +0100, Lukas Wunner wrote:
> On Wed, Jan 11, 2017 at 09:04:48PM -0500, Lyude Paul wrote:
> > Finally got koji to work :). People having the runtime resume problem,
> > can you give this kernel RPM a try and tell me if the issue still
> > persists?
> > 
> > https://koji.fedoraproject.org/koji/taskinfo?taskID=17250338
> 
> Kilian uses Debian but has a git repo with Linus' tree.  Could you post
> the relevant patch(es) based on either the tip of Linus' master branch
> or one of his tags (such as v4.9, v4.10-rc3)?  This would also allow us
> to review/comment on the patches.

Hi Lyude,

Just a reminder. Can you post the patch(es) here so that people can try
them out and comment?
