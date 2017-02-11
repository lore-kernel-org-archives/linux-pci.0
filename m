Return-Path: <SRS0=9w2o=ZY=linaro.org=linus.walleij@kernel.org>
Return-Path: <SRS0=9w2o=ZY=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170210204500.GK29169@bhelgaas-glaptop.roam.corp.google.com>
References: <20170126132707.23249-1-linus.walleij@linaro.org>
 <20170210200711.GG29169@bhelgaas-glaptop.roam.corp.google.com> <20170210204500.GK29169@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 11 Feb 2017 14:29:59 +0100
Message-ID: <CACRpkdbboyr-1-fRxnQHfMT2daZ97Edd9wOBvyJwSqkZ7stXMg@mail.gmail.com>
Subject: Re: [PATCH] pci: host: dra7xx: use GPIO descriptor
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2017 at 9:45 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Kishon's is slightly different because it uses devm_gpiod_get_optional()
> instead of devm_gpiod_get().

Fair enough.

> They both look slightly funny because we throw away the struct gpio_desc *
> that's returned, without ever using it anywhere (except to test for error).
> I *assume* that's what you want, since that's the way it was before the
> patch, too.

It's a hog-type usecase: when you request the GPIO it is set to a value
that you never want to change.

When the module is .exit():ed the descriptor will be garbage collected
thanks to using the devm_* accessor.

Yours,
Linus Walleij
